class AddFormatToResources < ActiveRecord::Migration[7.1]
  def change
    add_column :resources, :format, :string
  end
end
