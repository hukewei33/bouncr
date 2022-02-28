class CreateFriends < ActiveRecord::Migration[6.1]
  def change
    create_table :friends do |t|
      t.references :user1, null: false
      t.references :user2, null: false
      t.boolean :accpeted

      t.timestamps
    end
    add_foreign_key :friends, :users, column: :user1_id
    add_foreign_key :friends, :users, column: :user2_id
  end
end
