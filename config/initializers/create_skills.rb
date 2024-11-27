# Assurez-vous que SKILL_LIST est défini
SKILL_LIST = {
  skill1: { name: "Ruby", wagon_level: 50 },
  skill2: { name: "JavaScript", wagon_level: 50 },
  skill3: { name: "Python", wagon_level: 50 },
  skill4: { name: "Java", wagon_level: 50 },
  skill5: { name: "C++", wagon_level: 50 },
  skill6: { name: "TypeScript", wagon_level: 50 },
  skill7: { name: "PHP", wagon_level: 50 },
  skill8: { name: "Java", wagon_level: 50 },
  skill9: { name: "React", wagon_level: 25 },
  skill10: { name: "Node", wagon_level: 50 },
  skill11: { name: "Vue", wagon_level: 50 },
  skill12: { name: "Database", wagon_level: 50 },
  skill13: { name: "Interview Preparation", wagon_level: 50 },
  skill14: { name: "Product Design", wagon_level: 50 },
  skill15: { name: "Soft Skills", wagon_level: 50 },
}

# Créer toutes les skills en fonction de la constante SKILL_LIST
SKILL_LIST.each do |_, data|
  Skill.find_or_create_by(name: data[:name])
end
