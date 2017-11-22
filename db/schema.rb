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

ActiveRecord::Schema.define(version: 20171029133716) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_blog_modules", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.string "layout"
    t.integer "post_page_id"
    t.integer "blog_posts_count", default: 0
    t.integer "posts_pr_page", default: 10
    t.integer "admin_blog_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale", default: "en"
    t.integer "admin_blog_post_category"
    t.index ["admin_blog_id"], name: "index_admin_blog_modules_on_admin_blog_id"
    t.index ["post_page_id"], name: "index_admin_blog_modules_on_post_page_id"
  end

  create_table "admin_blog_post_categories", force: :cascade do |t|
    t.string "locale", default: "en"
    t.string "name", default: ""
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "legacy_id"
    t.integer "blog_post_count", default: 0
    t.integer "page_id"
    t.index ["page_id"], name: "index_admin_blog_post_categories_on_page_id"
  end

  create_table "admin_blog_posts", force: :cascade do |t|
    t.integer "legacy_id"
    t.string "title"
    t.text "subtitle"
    t.text "teaser"
    t.text "body"
    t.integer "position"
    t.integer "blog_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.integer "admin_blog_post_category_id"
    t.string "layout", default: "image_top"
    t.boolean "free_content", default: false
    t.integer "views", default: 0
    t.string "signature", default: ""
    t.index ["admin_blog_post_category_id"], name: "index_admin_blog_posts_on_admin_blog_post_category_id"
    t.index ["blog_id"], name: "index_admin_blog_posts_on_blog_id"
    t.index ["user_id"], name: "index_admin_blog_posts_on_user_id"
  end

  create_table "admin_blogs", force: :cascade do |t|
    t.string "title"
    t.string "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blog_posts_count", default: 0
    t.integer "category_id"
    t.index ["category_id"], name: "index_admin_blogs_on_category_id"
  end

  create_table "admin_calendar_events", force: :cascade do |t|
    t.integer "calendar_id"
    t.string "title"
    t.text "body"
    t.text "location"
    t.string "gmap"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["calendar_id"], name: "index_admin_calendar_events_on_calendar_id"
  end

  create_table "admin_calendar_modules", force: :cascade do |t|
    t.string "name"
    t.bigint "admin_calendar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "layout", default: "month-detailed"
    t.index ["admin_calendar_id"], name: "index_admin_calendar_modules_on_admin_calendar_id"
  end

  create_table "admin_calendars", force: :cascade do |t|
    t.string "title"
    t.integer "calendar_events_count"
    t.string "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_carousel_modules", force: :cascade do |t|
    t.string "name"
    t.string "layout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_carousel_slides", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "position", default: 0
    t.integer "page_id"
    t.integer "carousel_module_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["carousel_module_id"], name: "index_admin_carousel_slides_on_carousel_module_id"
    t.index ["page_id"], name: "index_admin_carousel_slides_on_page_id"
  end

  create_table "admin_csv_imports", force: :cascade do |t|
    t.string "name"
    t.string "import_type"
    t.text "comments"
    t.text "summary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "csv_file_file_name"
    t.string "csv_file_content_type"
    t.integer "csv_file_file_size"
    t.datetime "csv_file_updated_at"
  end

  create_table "admin_dmi_modules", force: :cascade do |t|
    t.string "forecast_duration", default: "days_two_forecast"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_featured_post_modules", force: :cascade do |t|
    t.string "name"
    t.integer "admin_blog_module_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_blog_module_id"], name: "index_admin_featured_post_modules_on_admin_blog_module_id"
  end

  create_table "admin_footers", force: :cascade do |t|
    t.string "title", default: ""
    t.string "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.integer "about_page_id"
    t.string "about_page_link_name", default: ""
    t.integer "copyright_page_id"
    t.string "copyright_page_link_name", default: ""
    t.integer "term_of_usage_page_id"
    t.string "term_of_usage_page_link_name"
    t.string "company_name"
    t.string "phone"
    t.string "vat_nr"
  end

  create_table "admin_gallery_images", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "gallery_module_id"
    t.bigint "user_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["gallery_module_id"], name: "index_admin_gallery_images_on_gallery_module_id"
    t.index ["user_id"], name: "index_admin_gallery_images_on_user_id"
  end

  create_table "admin_gallery_modules", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.string "layout"
    t.integer "page_id"
    t.integer "gallery_images_count", default: 0
    t.integer "images_pr_page", default: 16
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color", default: "#000000"
    t.string "background_color", default: "#FFFFFF"
    t.index ["page_id"], name: "index_admin_gallery_modules_on_page_id"
  end

  create_table "admin_image_modules", force: :cascade do |t|
    t.string "layout"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color", default: "#000000"
    t.string "background_color", default: "#FFFFFF"
  end

  create_table "admin_menu_contents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_menu_links", force: :cascade do |t|
    t.string "title", default: ""
    t.integer "page_id"
    t.string "url", default: ""
    t.boolean "active", default: true
    t.string "color", default: "#000"
    t.string "background_color", default: "#FFF"
    t.integer "menu_content_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_content_id"], name: "index_admin_menu_links_on_menu_content_id"
  end

  create_table "admin_menu_modules", force: :cascade do |t|
    t.string "name"
    t.integer "menu_content_id"
    t.string "layout", default: "vertical"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_content_id"], name: "index_admin_menu_modules_on_menu_content_id"
  end

  create_table "admin_module_names", force: :cascade do |t|
    t.string "name"
    t.string "locale"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_post_modules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_subscription_modules", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "layout"
    t.string "expired_title"
    t.text "expired_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_subscription_types", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "internet_version"
    t.boolean "print_version"
    t.decimal "price"
    t.string "locale"
    t.boolean "active"
    t.integer "duration"
    t.integer "position", default: 0
    t.integer "subscriptions_count"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "subscription_type_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "on_hold_date"
    t.integer "subscription_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_type_id"], name: "index_admin_subscriptions_on_subscription_type_id"
    t.index ["user_id"], name: "index_admin_subscriptions_on_user_id"
  end

  create_table "admin_system_messages", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "identifier"
    t.string "locale"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_system_setups", force: :cascade do |t|
    t.boolean "maintenance"
    t.integer "landing_page_id"
    t.integer "subscription_page_id"
    t.string "locale"
    t.string "locale_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "background_color", default: "none"
    t.string "logo_file_name"
    t.string "logo_content_type"
    t.integer "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "admin_text_modules", force: :cascade do |t|
    t.string "title", default: ""
    t.text "body", default: ""
    t.string "url"
    t.string "url_text"
    t.integer "page_id"
    t.string "color", default: "#000000"
    t.string "background_color", default: "#FFFFFF"
    t.boolean "border", default: false
    t.string "image_style", default: "full-width"
    t.string "link_layout", default: "text"
    t.string "image_ratio", default: "2_1"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.index ["page_id"], name: "index_admin_text_modules_on_page_id"
    t.index ["user_id"], name: "index_admin_text_modules_on_user_id"
  end

  create_table "admin_youtube_modules", force: :cascade do |t|
    t.string "name"
    t.text "snippet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "page_col_modules", force: :cascade do |t|
    t.bigint "page_col_id"
    t.string "moduleable_type"
    t.bigint "moduleable_id"
    t.integer "position", default: 0
    t.integer "margin_bottom", default: 20
    t.string "access_to", default: "all"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["moduleable_type", "moduleable_id"], name: "index_page_col_modules_on_moduleable_type_and_moduleable_id"
    t.index ["page_col_id"], name: "index_page_col_modules_on_page_col_id"
  end

  create_table "page_cols", force: :cascade do |t|
    t.bigint "page_row_id"
    t.string "layout"
    t.integer "index", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_row_id"], name: "index_page_cols_on_page_row_id"
  end

  create_table "page_rows", force: :cascade do |t|
    t.bigint "page_id"
    t.string "layout", default: "12"
    t.string "background_color", default: "none"
    t.integer "padding_top", default: 0
    t.integer "padding_bottom", default: 0
    t.integer "position", default: 0
    t.string "background_image_file_name"
    t.string "background_image_content_type"
    t.integer "background_image_file_size"
    t.datetime "background_image_updated_at"
    t.integer "page_cols_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_page_rows_on_page_id"
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.string "menu_title"
    t.string "menu_id"
    t.integer "menu_position", default: 0
    t.boolean "active"
    t.string "locale"
    t.string "body_background_file_name"
    t.string "body_background_content_type"
    t.integer "body_background_file_size"
    t.datetime "body_background_updated_at"
    t.integer "page_rows_count", default: 0
    t.string "background_color", default: "none"
    t.bigint "admin_footer_id"
    t.boolean "cache_page", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_footer_id"], name: "index_pages_on_admin_footer_id"
  end

  create_table "payments", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "postal_code_and_city"
    t.integer "subscription_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subscription_id"], name: "index_payments_on_subscription_id"
    t.index ["user_id"], name: "index_payments_on_user_id"
  end

  create_table "pg_search_documents", force: :cascade do |t|
    t.text "content"
    t.string "searchable_type"
    t.bigint "searchable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["searchable_type", "searchable_id"], name: "index_pg_search_documents_on_searchable_type_and_searchable_id"
  end

  create_table "roles", force: :cascade do |t|
    t.bigint "user_id"
    t.string "permission", default: "member"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", default: "", null: false
    t.string "password_digest", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer "legacy_id"
    t.boolean "free_subscription", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blog_posts_count", default: 0
    t.string "signature"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "admin_subscriptions", "users"
  add_foreign_key "page_col_modules", "page_cols"
  add_foreign_key "page_cols", "page_rows"
  add_foreign_key "page_rows", "pages"
  add_foreign_key "pages", "admin_footers"
  add_foreign_key "payments", "users"
  add_foreign_key "roles", "users"
end
