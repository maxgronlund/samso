# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170702090821) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_system_setups", force: :cascade do |t|
    t.boolean "maintenance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_modules", force: :cascade do |t|
    t.bigint "page_id"
    t.string "moduleable_type"
    t.bigint "moduleable_id"
    t.integer "slot_id"
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moduleable_type", "moduleable_id"], name: "index_page_modules_on_moduleable_type_and_moduleable_id"
    t.index ["page_id"], name: "index_page_modules_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.string "menu_title"
    t.string "menu_id"
    t.integer "menu_position", default: 0
    t.boolean "active"
    t.string "locale"
    t.bigint "user_id"
    t.string "layout", default: "alabama"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.text "identifier"
    t.integer "position"
    t.string "locale", default: "da"
    t.string "postable_type"
    t.bigint "postable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["postable_type", "postable_id"], name: "index_posts_on_postable_type_and_postable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "permission", default: "member"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "text_modules", force: :cascade do |t|
    t.string "title", default: ""
    t.text "body", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "layout"
    t.string "url"
    t.string "url_text"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "image_size"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "page_modules", "pages"
  add_foreign_key "roles", "users"
end
