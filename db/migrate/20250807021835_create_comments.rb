class CreateComments < ActiveRecord::Migration[8.0]
  def change
    create_table :comments do |t|
      t.references :issue, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
