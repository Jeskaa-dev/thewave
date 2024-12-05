class AddCareerProgramToUsers < ActiveRecord::Migration[7.1]
    def change
      add_column :users, :career_program, :string
    end
end
