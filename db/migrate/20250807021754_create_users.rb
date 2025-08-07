class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username
      t.string :password_digest
      t.integer :role, default: 1
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :users, :username, unique: true, where: "deleted_at IS NULL"
  end
end
