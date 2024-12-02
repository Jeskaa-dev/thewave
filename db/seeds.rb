<<<<<<< HEAD
=======
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


<<<<<<< HEAD
>>>>>>> 0374b5a97e963a6b7d893bb5e1adfef66bbb2a5c
=======
# Créer des ressources pour différents niveaux de difficulté
Skill.all.each do |skill|
  FRAME_LEVEL.each do |level, data|
    Resource.create(skill: skill, difficulty: data[:difficulty], name: "Resource for #{skill.name} - #{data[:difficulty]}")
  end
end
>>>>>>> 7ec7810037b3423006f1f9cc16f95d7d28e5416f
