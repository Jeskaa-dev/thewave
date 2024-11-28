# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

FORMAT_CHOICES = ["Vidéo", "Exercices", "Formation"]

# Créer toutes les skills en fonction de la constante SKILL_LIST
SKILL_LIST.each do |_, data|
  skill = Skill.find_or_create_by(name: data[:name]) do |s|
    s.wagon_level = data[:wagon_level]
  end
  puts "Created or found skill: #{skill.name}"
end

# Créer des ressources pour différents niveaux de difficulté
Skill.all.each do |skill|
  10.times do |i|
    difficulty = FRAME_LEVEL.values.sample[:difficulty]
    format = FORMAT_CHOICES.sample
    resource = Resource.create(
      skill: skill,
      difficulty: difficulty,
      format: format,
      name: "Resource #{i + 1} for #{skill.name} - #{difficulty}"
    )
    puts "Created resource: #{resource.name} with difficulty: #{resource.difficulty} and format: #{resource.format}"
  end
end
