class CreateProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :projects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.integer :visibility, default: 0
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :projects, [ :user_id, :name ], unique: true, where: "deleted_at IS NULL"
  end
end
