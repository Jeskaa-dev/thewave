require 'net/http'
require 'uri'
require 'json'

class User < ApplicationRecord
  before_save :fetch_github_commits
  has_many :training_plans
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :trainings, through: :training_plans
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable



  private

  def fetch_github_commits
    @commit_status = {}
    # token = self.github_token

    GITHUB_PATHS.each do |repo, path|
      uri = URI.parse("https://api.github.com/repos/#{github_id}#{path}#{github_id}")
      request = Net::HTTP::Get.new(uri)
      request["Accept"] = "application/vnd.github+json"
      # request["Authorization"] = "Bearer #{token}"
      request["X-GitHub-Api-Version"] = "2022-11-28"

      response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
        http.request(request)
      end

      if response.code.to_i == 200
        commits = JSON.parse(response.body)
        @commit_status[repo] = { done: commits.any? }
      else
        Rails.logger.error("Failed to fetch commits for repo #{repo}: #{response.body}")
        @commit_status[repo] = { done: false }
      end
    end
  end
end
