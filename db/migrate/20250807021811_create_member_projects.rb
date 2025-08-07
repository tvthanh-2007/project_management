class CreateMemberProjects < ActiveRecord::Migration[8.0]
  def change
    create_table :member_projects do |t|
      t.references :user, null: false, foreign_key: true
      t.references :project, null: false, foreign_key: true
      t.integer :role, default: 2
      t.datetime :deleted_at

      t.timestamps
    end

    add_index :member_projects, [ :user_id, :project_id ], unique: true, where: "deleted_at IS NULL"
  end
end
