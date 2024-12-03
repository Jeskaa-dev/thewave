class TrainingPlan < ApplicationRecord
  belongs_to :user
  has_many :completions, dependent: :destroy
  has_many :resources, through: :completions
end
