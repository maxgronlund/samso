# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_11_084524) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "pg_trgm"
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "addressable_type"
    t.bigint "addressable_id"
    t.string "name"
    t.string "address"
    t.string "zipp_code"
    t.string "city"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address_type", default: "primary_address"
    t.date "start_date"
    t.date "end_date"
    t.string "country", default: "Danmark"
    t.string "first_name"
    t.string "middle_name"
    t.string "last_name"
    t.string "street_name"
    t.integer "house_number"
    t.string "letter"
    t.string "floor"
    t.string "side"
    t.index ["address_type"], name: "index_addresses_on_address_type"
    t.index ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"
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
    t.date "start_date"
    t.date "end_date"
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

  create_table "admin_blog_post_contents", force: :cascade do |t|
    t.string "layout", default: "image_top"
    t.text "body"
    t.string "image_caption"
    t.text "video_url", default: ""
    t.integer "position"
    t.bigint "admin_blog_post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.index ["admin_blog_post_id"], name: "index_admin_blog_post_contents_on_admin_blog_post_id"
  end

  create_table "admin_blog_post_images", force: :cascade do |t|
    t.string "image_caption"
    t.bigint "admin_blog_post_id"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.index ["admin_blog_post_id"], name: "index_admin_blog_post_images_on_admin_blog_post_id"
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
    t.integer "obsolete_views", default: 0
    t.string "signature", default: ""
    t.integer "post_page_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.text "video_url", default: ""
    t.boolean "enable_comments", default: false
    t.boolean "show_facebook_comments", default: true
    t.string "image_caption"
    t.integer "comments_count", default: 0
    t.index "(((((setweight(to_tsvector('danish'::regconfig, (COALESCE(title, ''::character varying))::text), 'A'::\"char\") || ''::tsvector) || setweight(to_tsvector('danish'::regconfig, COALESCE(subtitle, ''::text)), 'B'::\"char\")) || ''::tsvector) || setweight(to_tsvector('danish'::regconfig, COALESCE(body, ''::text)), 'C'::\"char\")))", name: "admin_blog_posts_fts_idx", using: :gin
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
    t.integer "index_page_id"
    t.integer "show_page_id"
    t.index ["index_page_id"], name: "index_admin_blogs_on_index_page_id"
    t.index ["show_page_id"], name: "index_admin_blogs_on_show_page_id"
    t.index ["title"], name: "index_admin_blogs_on_title"
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
    t.bigint "image_file_size"
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
    t.bigint "csv_file_file_size"
    t.datetime "csv_file_updated_at"
    t.datetime "imported"
  end

  create_table "admin_dmi_modules", force: :cascade do |t|
    t.string "forecast_duration", default: "days_two_forecast"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_e_page_free_modules", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "link"
    t.string "image_link"
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

  create_table "admin_event_notifications", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "message_type"
    t.string "state", default: "pending"
    t.text "metadata"
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

  create_table "admin_find_blog_post_modules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.bigint "image_file_size"
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

  create_table "admin_iframe_modules", force: :cascade do |t|
    t.string "name"
    t.text "snippet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_image_modules", force: :cascade do |t|
    t.string "layout"
    t.string "color", default: "#000000"
    t.string "background_color", default: "#FFFFFF"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_logs", force: :cascade do |t|
    t.string "title"
    t.string "log_type"
    t.hstore "info"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "loggable_id"
    t.string "loggable_type"
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
    t.integer "position", default: 0
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
    t.index ["name"], name: "index_admin_module_names_on_name"
  end

  create_table "admin_most_popular_modules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "articles", default: 8
  end

  create_table "admin_newsletter_posts", force: :cascade do |t|
    t.bigint "admin_blog_post_id"
    t.bigint "admin_newsletter_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_blog_post_id"], name: "index_admin_newsletter_posts_on_admin_blog_post_id"
    t.index ["admin_newsletter_id"], name: "index_admin_newsletter_posts_on_admin_newsletter_id"
  end

  create_table "admin_newsletters", force: :cascade do |t|
    t.string "locale"
    t.string "title", default: ""
    t.text "body", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "state", default: "pending"
  end

  create_table "admin_post_modules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_printed_ads", force: :cascade do |t|
    t.string "title", default: ""
    t.text "body", default: ""
    t.integer "impressions", default: 0
    t.boolean "active", default: false
    t.integer "position", default: 0
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
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

  create_table "admin_search_result_modules", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_sign_in_ips", force: :cascade do |t|
    t.inet "ip"
    t.datetime "sign_in_at"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "count", default: 1
    t.hstore "ipinfo", default: {}, null: false
    t.index ["user_id"], name: "index_admin_sign_in_ips_on_user_id"
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
    t.string "group", default: "Abonnement"
    t.boolean "send_reminder", default: false
    t.integer "remind_before_days", default: 1
    t.index ["identifier"], name: "index_admin_subscription_types_on_identifier"
  end

  create_table "admin_subscriptions", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "subscription_type_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "on_hold_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "reminder_send"
    t.boolean "send_reminder", default: false
    t.integer "subscription_id"
    t.uuid "last_payment_uuid"
    t.index ["subscription_id"], name: "index_admin_subscriptions_on_subscription_id"
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
    t.bigint "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer "search_page_id"
    t.string "administrator_email"
    t.string "editor_emails", default: ""
    t.string "e_pages_date"
    t.integer "last_subscription_id", default: 8005250
    t.string "order_completed_email"
    t.index ["locale", "id"], name: "index_admin_system_setups_on_locale_and_id"
    t.index ["locale"], name: "index_admin_system_setups_on_locale"
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
    t.bigint "image_file_size"
    t.datetime "image_updated_at"
    t.index ["page_id"], name: "index_admin_text_modules_on_page_id"
    t.index ["user_id"], name: "index_admin_text_modules_on_user_id"
  end

  create_table "admin_weekly_comment_modules", force: :cascade do |t|
    t.string "name"
    t.integer "articles", default: 8
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "admin_youtube_modules", force: :cascade do |t|
    t.string "name"
    t.text "snippet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ads", force: :cascade do |t|
    t.date "start_date"
    t.integer "number_of_columns"
    t.text "body"
    t.text "comment"
    t.string "name"
    t.string "address"
    t.string "zipp_code"
    t.string "city"
    t.string "email"
    t.string "phone"
    t.string "contact_person"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "blog_post_stats", force: :cascade do |t|
    t.bigint "admin_blog_post_id"
    t.integer "views", default: 0
    t.datetime "start_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "weekly_views_count", default: 0
    t.integer "weekly_comments_count", default: 0
    t.index ["admin_blog_post_id"], name: "index_blog_post_stats_on_admin_blog_post_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.bigint "user_id"
    t.string "commentable_type"
    t.bigint "commentable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "author_name", default: ""
    t.string "state", default: "default"
    t.integer "weekly_comments_count", default: 0
    t.integer "admin_blog_post_id"
    t.index ["admin_blog_post_id"], name: "index_comments_on_admin_blog_post_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "e_paper_tokens", force: :cascade do |t|
    t.bigint "user_id"
    t.string "secret"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["secret"], name: "index_e_paper_tokens_on_secret"
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
    t.index ["moduleable_type"], name: "index_page_col_modules_on_moduleable_type"
    t.index ["page_col_id"], name: "index_page_col_modules_on_page_col_id"
  end

  create_table "page_cols", force: :cascade do |t|
    t.bigint "page_row_id"
    t.string "layout"
    t.integer "index", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["index"], name: "index_page_cols_on_index"
    t.index ["layout"], name: "index_page_cols_on_layout"
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
    t.boolean "category_page", default: false
    t.index ["admin_footer_id"], name: "index_pages_on_admin_footer_id"
    t.index ["locale"], name: "index_pages_on_locale"
    t.index ["menu_title"], name: "index_pages_on_menu_title"
    t.index ["title"], name: "index_pages_on_title"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid"
    t.string "state", default: "pending"
    t.hstore "transaction_info", default: {}, null: false
    t.string "payment_provider"
    t.integer "payable_id"
    t.string "payable_type"
    t.string "onpay_reference", default: "na"
    t.index ["onpay_reference"], name: "index_payments_on_onpay_reference"
    t.index ["user_id"], name: "index_payments_on_user_id"
    t.index ["uuid"], name: "index_payments_on_uuid"
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
    t.index ["permission"], name: "index_roles_on_permission"
    t.index ["user_id"], name: "index_roles_on_user_id"
  end

  create_table "service_functions_printed_ads", force: :cascade do |t|
    t.date "start_date"
    t.integer "number_of_columns"
    t.text "body"
    t.text "comment"
    t.string "name"
    t.string "address"
    t.string "zipp_code"
    t.string "city"
    t.string "email"
    t.string "phone"
    t.string "contact_person"
    t.string "state", default: "pending"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "week", default: 1
    t.integer "year", default: 2020
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: ""
    t.string "signature", default: ""
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
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "blog_posts_count", default: 0
    t.integer "e_paper_tokens_count"
    t.boolean "gdpr_accepted", default: false
    t.integer "sign_in_ips_count", default: 0
    t.boolean "subscribe_to_news", default: false
    t.datetime "latest_online_payment"
    t.uuid "uuid"
    t.integer "comments_count", default: 0
    t.integer "legacy_id"
    t.string "auth_token"
    t.index ["auth_token"], name: "index_users_on_auth_token"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["signature"], name: "index_users_on_signature"
    t.index ["user_id"], name: "index_users_on_user_id"
    t.index ["uuid"], name: "index_users_on_uuid"
  end

  create_table "weekly_comments", force: :cascade do |t|
    t.bigint "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_weekly_comments_on_comment_id"
  end

  create_table "weekly_views", force: :cascade do |t|
    t.bigint "blog_post_stat_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["blog_post_stat_id"], name: "index_weekly_views_on_blog_post_stat_id"
  end

  add_foreign_key "admin_blog_post_contents", "admin_blog_posts"
  add_foreign_key "admin_blog_post_images", "admin_blog_posts"
  add_foreign_key "admin_newsletter_posts", "admin_blog_posts"
  add_foreign_key "admin_newsletter_posts", "admin_newsletters"
  add_foreign_key "admin_sign_in_ips", "users"
  add_foreign_key "admin_subscriptions", "users"
  add_foreign_key "blog_post_stats", "admin_blog_posts"
  add_foreign_key "comments", "users"
  add_foreign_key "e_paper_tokens", "users"
  add_foreign_key "page_col_modules", "page_cols"
  add_foreign_key "page_cols", "page_rows"
  add_foreign_key "page_rows", "pages"
  add_foreign_key "pages", "admin_footers"
  add_foreign_key "payments", "users"
  add_foreign_key "roles", "users"
  add_foreign_key "weekly_comments", "comments"
  add_foreign_key "weekly_views", "blog_post_stats"
end
