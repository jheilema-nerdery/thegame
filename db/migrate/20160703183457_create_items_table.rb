class CreateItemsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :case
      t.string :name
      t.string :api_id
      t.integer :rarity
      t.string :description
      t.timestamps
    end
  end
end
