class TrainingPlan < ApplicationRecord
  belongs_to :user
  has_many :resources
end
