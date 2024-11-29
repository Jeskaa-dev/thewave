class AddGithubFieldsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :github_token, :string
  end
end
