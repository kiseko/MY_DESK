class CreateSceneItems < ActiveRecord::Migration[5.2]
  def change
    create_table :scene_items do |t|

      t.integer :scene_id, null: false
      t.integer :item_id, null: false

      t.timestamps null: false
    end
  end
end
