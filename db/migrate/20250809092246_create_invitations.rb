class CreateInvitations < ActiveRecord::Migration[8.0]
  def change
    create_table :invitations do |t|
      t.references :project, null: false, foreign_key: true
      t.string :email
      t.string :role, null: false
      t.string :token, null: false
      t.datetime :expires_at
      t.datetime :accepted_at

      t.timestamps
    end
  end
end
