require 'net/http'
require 'uri'
require 'json'
require 'dotenv/load' # Assurez-vous que dotenv est chargé

class User < ApplicationRecord
  # before_save :fetch_github_commits
  has_many :training_plans
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :trainings, through: :training_plans
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
        wagon_level = SKILL_LIST.find { |_, v| v[:name] == langage }&.dig(1, :wagon_level) || 50
        rating = (successful_commits.to_f / total_commits * wagon_level).round
        UserSkill.create(user: self, skill: skill, rating: rating)
      end
    end

    # Instancier un plan de formation pour chaque skill
    create_training_plan(skills)

    @commit_status
  end

  private

  def create_training_plan(skills)
    skills.each do |langage, skill|
      user_skill = user_skills.find_by(skill: skill)
      next unless user_skill

      FRAME_LEVEL.each do |level, data|
        if user_skill.rating < data[:min]
          training_plan = training_plans.create(skill: skill, user: self)
          resources = Resource.where(skill: skill, difficulty: data[:difficulty])
          resources.each do |resource|
            training_plan.resources << resource
          end
        end
      end
    end
  end
end
