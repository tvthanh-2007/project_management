class CreateTokens < ActiveRecord::Migration[8.0]
  def change
    create_table :tokens do |t|
      t.references :user, null: false, foreign_key: true
      t.string :access_token
      t.string :refresh_token
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
