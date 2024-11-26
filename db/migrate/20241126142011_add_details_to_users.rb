class AddDetailsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :last_name, :string
    add_column :users, :first_name, :string
    add_column :users, :age, :integer
    add_column :users, :location, :string
    add_column :users, :github_id, :integer
    add_column :users, :carrer_programs, :string
    add_column :users, :batch_number, :integer
    add_column :users, :image_url, :string
  end
end
