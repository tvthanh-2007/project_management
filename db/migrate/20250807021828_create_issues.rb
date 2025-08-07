class CreateIssues < ActiveRecord::Migration[8.0]
  def change
    create_table :issues do |t|
      t.references :project, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.integer :created_by
      t.integer :status
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
