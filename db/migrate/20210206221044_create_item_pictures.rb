class CreateItemPictures < ActiveRecord::Migration[5.2]
  def change
    create_table :item_pictures do |t|

      t.integer :item_id, null: false
      t.string :image_id, null: false

      t.timestamps null: false
    end
  end
end
