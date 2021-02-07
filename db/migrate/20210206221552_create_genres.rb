class CreateGenres < ActiveRecord::Migration[5.2]
  def change
    create_table :genres do |t|

      t.integer :item_id, null: false
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
