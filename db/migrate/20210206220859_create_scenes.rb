class CreateScenes < ActiveRecord::Migration[5.2]
  def change
    create_table :scenes do |t|

      t.integer :user_id, null: false
      t.string :image_id, null: false

      t.timestamps null: false
    end
  end
end
