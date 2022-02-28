class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.references :user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true
      t.datetime :checkinTime
      t.boolean :inviteStatus
      t.boolean :checkinStatus
      t.integer :phoneNumber
      t.integer :coverChargePaid

      t.timestamps
    end
  end
end
