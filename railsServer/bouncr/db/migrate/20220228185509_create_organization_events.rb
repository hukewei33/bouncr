class CreateOrganizationEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :organization_events do |t|
      t.references :organization, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
