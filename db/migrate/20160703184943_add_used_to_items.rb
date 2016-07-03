class AddUsedToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :used, :boolean, default: false
    add_column :items, :action, :string
  end
end
