class CreateJobs < ActiveRecord::Migration[5.0]
  def change
    create_table :jobs do |t|
      t.string :target
      t.string :item_name

      t.timestamps
    end
  end
end
