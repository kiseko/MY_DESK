class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|

      t.integer :user_id, null: false
      t.integer :item_id, null: false
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
