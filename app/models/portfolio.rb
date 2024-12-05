class Portfolio < ApplicationRecord
  belongs_to :user

  def completion_percentage

    steps = [
      step_1_github_url, step_1_site_url,
      step_2_github_url, step_2_site_url,
      step_3_github_url, step_3_site_url
    ]

    completed_steps = steps.compact.reject(&:blank?).count
    total_steps = steps.size


    ((completed_steps.to_f / total_steps) * 100).round
  end
end
