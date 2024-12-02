class TrainingPlan < ApplicationRecord
  belongs_to :user
  has_many :completions
  has_many :resources, through: :completions
end
