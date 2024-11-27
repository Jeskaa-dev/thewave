require 'net/http'
require 'uri'
require 'json'
require 'dotenv/load' # Assurez-vous que dotenv est chargé

class User < ApplicationRecord
  # before_save :fetch_github_commits
  has_many :training_plans
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :resources, through: :training_plans
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def fetch_github_commits
    @commit_status = {}
    token = ENV['GIT_TOKEN_TEST']

    GITHUB_PATHS.each do |repo, data|
      path = data[:path]
      langage = data[:langage]
      optional = data[:Optional] == "true"
      base_url = "https://api.github.com/repos/#{github_id}#{path}#{github_id}"
      uri = URI(base_url)
      puts uri

      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      request["Authorization"] = "Bearer #{token}"
      request["X-GitHub-Api-Version"] = "2022-11-28"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      if response.code.to_i == 200
        commits = JSON.parse(response.body)
        @commit_status[repo] = { done: commits.any?, langage: langage, optional: optional }
      else
        Rails.logger.error("Failed to fetch commits for repo #{repo}: #{response.body}")
        @commit_status[repo] = { done: false, langage: langage, optional: optional }
      end
    end

    # Créer des instances de Skill pour chaque langage unique
    skills = {}
    @commit_status.each_value do |status|
      langage = status[:langage]
      skills[langage] ||= Skill.find_or_create_by(name: langage)
    end

    # Créer des instances de UserSkill et calculer le rating
    skills.each do |langage, skill|
      unless user_skills.exists?(skill: skill)
        total_commits = @commit_status.values.count { |status| status[:langage] == langage && !status[:optional] }
        successful_commits = @commit_status.values.count { |status| status[:langage] == langage && status[:done] }
        if total_commits > 0
          wagon_level = SKILL_LIST.find { |_, v| v[:name] == langage }&.dig(1, :wagon_level) || 50
          rating = (successful_commits.to_f / total_commits * wagon_level).round
          UserSkill.create(user: self, skill: skill, rating: rating)
        else
          Rails.logger.warn("No commits found for langage: #{langage}")
        end
      end
    end

    # Instancier un plan de formation global pour l'utilisateur
    create_training_plan

    @commit_status
  end

  private

  def create_training_plan
    # Créer un plan de formation global pour l'utilisateur
    training_plan = training_plans.create(user: self)
    puts "Created TrainingPlan ID: #{training_plan.id} for User: #{self.id}"

    # Balayer la liste exhaustive des noms contenus dans la constante SKILL_LIST
    SKILL_LIST.each do |_, data|
      skill = Skill.find_by(name: data[:name])
      next unless skill

      user_skill = user_skills.find_by(skill: skill)
      rating = user_skill ? user_skill.rating : 0

      # Associer des ressources au plan de formation en fonction du rating de UserSkill
      skill.resources.each do |resource|
        resource_min_difficulty = difficulty_to_min(resource.difficulty)
        if resource_min_difficulty && rating < resource_min_difficulty
          completion = Completion.create(training_plan: training_plan, resource: resource, done: false)
          puts "Associated Resource: #{resource.name} with TrainingPlan ID: #{training_plan.id}" if completion.persisted?
        end
      end
    end
  end

  def difficulty_to_min(difficulty)
    FRAME_LEVEL.each do |_, data|
      return data[:min] if data[:difficulty] == difficulty
    end
    nil
  end
end
