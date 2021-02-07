class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|

      t.integer :user_id, null: false
      t.string :brand
      t.string :name, null: false
      t.integer :comment_status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
