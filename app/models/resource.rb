class Resource < ApplicationRecord
  belongs_to :skill
  has_many :completions
  has_one_attached :photo
end
