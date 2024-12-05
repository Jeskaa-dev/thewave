class CreatePortfolios < ActiveRecord::Migration[7.1]
  def change
    create_table :portfolios do |t|
      t.references :user, null: false, foreign_key: true
      t.string :step_1_github_url
      t.string :step_1_site_url
      t.string :step_2_github_url
      t.string :step_2_site_url
      t.string :step_3_github_url
      t.string :step_3_site_url
      t.string :step_4_github_url
      t.string :step_4_site_url
      t.string :step_5_github_url
      t.string :step_5_site_url

      t.timestamps
    end
  end
end
