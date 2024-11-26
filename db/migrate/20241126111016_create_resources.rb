class CreateResources < ActiveRecord::Migration[7.1]
  def change
    create_table :resources do |t|
      t.string :name
      t.text :content
      t.string :image_url
      t.integer :price
      t.string :difficulty
      t.string :resource_url
      t.references :skill, null: false, foreign_key: true

      t.timestamps
    end
  end
end
