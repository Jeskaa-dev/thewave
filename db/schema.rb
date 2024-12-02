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

ActiveRecord::Schema[7.1].define(version: 2024_12_03_114560) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "completions", force: :cascade do |t|
    t.boolean "done"
    t.bigint "resource_id", null: false
    t.bigint "training_plan_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_completions_on_resource_id"
    t.index ["training_plan_id"], name: "index_completions_on_training_plan_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.string "image_url"
    t.integer "price"
    t.string "difficulty"
    t.string "resource_url"
    t.bigint "skill_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "format"
    t.index ["skill_id"], name: "index_resources_on_skill_id"
  end

  create_table "skills", force: :cascade do |t|
    t.string "name"
    t.string "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "wagon_level"
  end

  create_table "solid_cache_entries", force: :cascade do |t|
    t.binary "key", null: false
    t.binary "value", null: false
    t.datetime "created_at", null: false
    t.bigint "key_hash", null: false
    t.integer "byte_size", null: false
    t.index ["byte_size"], name: "index_solid_cache_entries_on_byte_size"
    t.index ["key_hash", "byte_size"], name: "index_solid_cache_entries_on_key_hash_and_byte_size"
    t.index ["key_hash"], name: "index_solid_cache_entries_on_key_hash", unique: true
  end

  create_table "training_plans", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_training_plans_on_user_id"
  end

  create_table "user_skills", force: :cascade do |t|
    t.integer "rating"
    t.bigint "skill_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["skill_id"], name: "index_user_skills_on_skill_id"
    t.index ["user_id"], name: "index_user_skills_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "last_name"
    t.string "first_name"
    t.integer "age"
    t.string "location"
    t.string "github_id"
    t.string "carrer_programs"
    t.integer "batch_number"
    t.string "image_url"
    t.string "provider"
    t.string "uid"
    t.string "github_token"
    t.string "github_username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "completions", "resources"
  add_foreign_key "completions", "training_plans"
  add_foreign_key "resources", "skills"
  add_foreign_key "training_plans", "users"
  add_foreign_key "user_skills", "skills"
  add_foreign_key "user_skills", "users"
end
