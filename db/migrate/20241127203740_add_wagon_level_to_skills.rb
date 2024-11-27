class AddWagonLevelToSkills < ActiveRecord::Migration[7.1]
  def change
    add_column :skills, :wagon_level, :integer
  end
end
