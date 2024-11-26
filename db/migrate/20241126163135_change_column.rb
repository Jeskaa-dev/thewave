class ChangeColumn < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :github_id, :string
  end
end
