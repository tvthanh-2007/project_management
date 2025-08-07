# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_08_07_021835) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "comments", force: :cascade do |t|
    t.bigint "issue_id", null: false
    t.bigint "user_id", null: false
    t.text "content"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_comments_on_issue_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "issues", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.string "title"
    t.text "description"
    t.integer "created_by"
    t.integer "status"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_issues_on_project_id"
  end

  create_table "member_projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "project_id", null: false
    t.integer "role", default: 2
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_member_projects_on_project_id"
    t.index ["user_id", "project_id"], name: "index_member_projects_on_user_id_and_project_id", unique: true, where: "(deleted_at IS NULL)"
    t.index ["user_id"], name: "index_member_projects_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "description"
    t.integer "visibility", default: 0
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "name"], name: "index_projects_on_user_id_and_name", unique: true, where: "(deleted_at IS NULL)"
    t.index ["user_id"], name: "index_projects_on_user_id"
  end

  create_table "tokens", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "access_token"
    t.string "refresh_token"
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_tokens_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.string "password_digest"
    t.integer "role", default: 1
    t.datetime "deleted_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true, where: "(deleted_at IS NULL)"
  end

  add_foreign_key "comments", "issues"
  add_foreign_key "comments", "users"
  add_foreign_key "issues", "projects"
  add_foreign_key "member_projects", "projects"
  add_foreign_key "member_projects", "users"
  add_foreign_key "projects", "users"
  add_foreign_key "tokens", "users"
end
