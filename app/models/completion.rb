class Completion < ApplicationRecord
  belongs_to :resource
  belongs_to :training_plan
end
