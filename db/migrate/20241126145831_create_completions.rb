class CreateCompletions < ActiveRecord::Migration[7.1]
  def change
    create_table :completions do |t|
      t.boolean :done
      t.references :resource, null: false, foreign_key: true
      t.references :training_plan, null: false, foreign_key: true

      t.timestamps
    end
  end
end
