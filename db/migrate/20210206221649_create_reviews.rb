class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|

      t.integer :item_id, null: false
      t.integer :rating, null: false
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
