class CreateFollowings < ActiveRecord::Migration[5.2]
  def change
    create_table :followings do |t|

      t.integer :user_id, null: false
      t.integer :following_user_id, null: false
      t.integer :status, null: false, default: 0

      t.timestamps null: false
    end
  end
end
