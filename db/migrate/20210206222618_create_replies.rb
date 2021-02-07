class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|

      t.integer :user_id, null: false
      t.integer :comment_id, null: false
      t.string :description, null: false

      t.timestamps null: false
    end
  end
end
