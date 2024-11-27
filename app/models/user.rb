require 'net/http'
require 'uri'
require 'json'
require 'dotenv/load'

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
    # token = self.github_token

    GITHUB_PATHS.each do |repo, data|
      path = data[:path]
      langage = data[:langage]
      optional = data[:Optional] == "true"
      uri = URI.parse("https://api.github.com/repos/#{github_id}#{path}#{github_id}")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      request["Authorization"] = "Bearer #{ENV['GIT_TOKEN_TEST']}"
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
        rating = (successful_commits.to_f / total_commits * 50).round
        UserSkill.create(user: self, skill: skill, rating: rating)
      end
    end

    @commit_status
  end

end
