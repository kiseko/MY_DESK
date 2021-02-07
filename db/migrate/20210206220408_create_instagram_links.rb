class CreateInstagramLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :instagram_links do |t|

      t.integer :user_id, null: false
      t.string :url, null: false
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
