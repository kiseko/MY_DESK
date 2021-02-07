class CreateHomepageLinks < ActiveRecord::Migration[5.2]
  def change
    create_table :homepage_links do |t|

      t.integer :item_id, null: false
      t.string :url, null: false

      t.timestamps null: false
    end
  end
end
