class Resource < ApplicationRecord
  belongs_to :skill
  has_many :completions
  has_many :training_plans, through: :completions
  # has_one_attached :photo

  FORMAT_CHOICES = %w[Vidéo Exercice Formation]

  validates :format, inclusion: { in: FORMAT_CHOICES }
  validates :difficulty, inclusion: { in: %w[Débutant Intermédiaire Professionnel] }
end
