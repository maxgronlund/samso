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

ActiveRecord::Schema.define(version: 2018_10_15_075909) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.bigint "user_id"
    t.string "name"
    t.string "address"
    t.integer "zipp_code"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_type", default: "user_address"
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "admin_advertisement_modules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_advertisements", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.decimal "price_pr_view", default: "0.0"
    t.integer "views", default: 0
    t.decimal "price_pr_click", default: "0.0"
    t.integer "clicks", default: 0
    t.datetime "start_date"
    t.datetime "end_date"
    t.boolean "active", default: true
    t.boolean "featured", default: false
    t.decimal "featured_price", default: "0.0"
    t.decimal "price", default: "0.0"
    t.string "url", default: ""
    t.string "locale"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "notes", default: ""
    t.integer "user_id"
    t.index ["user_id"], name: "index_admin_advertisements_on_user_id"
  end

  create_table "admin_blog_modules", force: :cascade do |t|
    t.string "name"
    t.text "body"
    t.string "layout"
    t.integer "blog_posts_count", default: 0
    t.integer "posts_pr_page", default: 10
    t.integer "admin_blog_id"
    t.string "locale"
    t.boolean "show_all_categories", default: false
    t.integer "featured_posts_pr_page", default: 0
    t.boolean "show_search", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_blog_id"], name: "index_admin_blog_modules_on_admin_blog_id"
  end

  create_table "admin_blog_posts", force: :cascade do |t|
    t.integer "legacy_id"
    t.string "title"
    t.string "layout", default: "image_top"
    t.text "subtitle"
    t.text "teaser"
    t.text "body"
    t.integer "position"
    t.integer "blog_id"
    t.boolean "free_content", default: false
    t.boolean "featured", default: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.bigint "user_id"
    t.integer "views", default: 0
    t.string "signature", default: ""
    t.integer "post_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.text "video_url", default: ""
    t.boolean "enable_comments", default: false
    t.index ["blog_id"], name: "index_admin_blog_posts_on_blog_id"
    t.index ["post_page_id"], name: "index_admin_blog_posts_on_post_page_id"
    t.index ["user_id"], name: "index_admin_blog_posts_on_user_id"
  end

  create_table "admin_blogs", force: :cascade do |t|
    t.string "title"
    t.string "locale"
    t.integer "legacy_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blog_posts_count", default: 0
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
    t.string "layout", default: "month_detailed"
    t.bigint "admin_calendar_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "admin_e_page_modules", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "link"
    t.string "image_link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_featured_post_modules", force: :cascade do |t|
    t.string "title"
    t.integer "admin_blog_module_id"
    t.integer "featured_posts_pr_page", default: 16
    t.string "content_type", default: "featured_posts"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blog_id"
    t.index ["admin_blog_module_id"], name: "index_admin_featured_post_modules_on_admin_blog_module_id"
    t.index ["blog_id"], name: "index_admin_featured_post_modules_on_blog_id"
  end

  create_table "admin_footers", force: :cascade do |t|
    t.string "title", default: ""
    t.string "locale"
    t.integer "about_page_id"
    t.string "about_page_link_name", default: ""
    t.integer "copyright_page_id"
    t.integer "integer"
    t.string "copyright_page_link_name", default: ""
    t.integer "term_of_usage_page_id"
    t.string "term_of_usage_page_link_name"
    t.string "email", default: ""
    t.string "company_name", default: ""
    t.string "phone", default: ""
    t.string "vat_nr", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "color", default: "#000000"
    t.string "background_color", default: "#FFFFFF"
    t.integer "gallery_images_count", default: 0
    t.integer "images_pr_page", default: 16
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["page_id"], name: "index_admin_gallery_modules_on_page_id"
  end

  create_table "admin_image_modules", force: :cascade do |t|
    t.string "layout"
    t.string "color", default: "#000000"
    t.string "background_color", default: "#FFFFFF"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "admin_read_also_modules", force: :cascade do |t|
    t.string "name"
    t.integer "blog_id"
    t.integer "posts_pr_page", default: 8
    t.boolean "show_all_categories", default: true
    t.boolean "image_on_top", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_id"], name: "index_admin_read_also_modules_on_blog_id"
  end

  create_table "admin_subscription_modules", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "layout"
    t.string "expired_title"
    t.text "expired_body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale", default: "en"
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
    t.boolean "free", default: false
    t.string "identifier", default: "internal"
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
    t.string "background_color", default: "none"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "user_id"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "e_paper_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_e_paper_tokens_on_user_id"
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
    t.string "menu_id", default: "not_in_any_menus"
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

  create_table "subscription_addresses", force: :cascade do |t|
    t.bigint "admin_subscription_id"
    t.bigint "address_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["address_id"], name: "index_subscription_addresses_on_address_id"
    t.index ["admin_subscription_id"], name: "index_subscription_addresses_on_admin_subscription_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "signature"
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
    t.string "address"
    t.string "postal_code_and_city"
    t.string "legacy_subscription_id"
    t.integer "e_paper_tokens_count"
    t.boolean "gdpr_accepted", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "users"
  add_foreign_key "admin_subscriptions", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "e_paper_tokens", "users"
  add_foreign_key "page_col_modules", "page_cols"
  add_foreign_key "page_cols", "page_rows"
  add_foreign_key "page_rows", "pages"
  add_foreign_key "pages", "admin_footers"
  add_foreign_key "payments", "users"
  add_foreign_key "roles", "users"
  add_foreign_key "subscription_addresses", "addresses"
  add_foreign_key "subscription_addresses", "admin_subscriptions"
end
