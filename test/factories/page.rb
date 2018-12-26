FactoryBot.define do
  factory :page do |f|
    f.title { 'Front page' }
    f.menu_id { 'not_in_any_menus' }
    f.menu_position { 0 }
    f.active { true }
    f.locale { 'en' }
    f.background_color { 'none' }
    f.cache_page { false }
    f.body_background_file_name { nil }
    f.body_background_content_type { nil }
    f.body_background_file_size { nil }
    f.body_background_updated_at { nil }
    f.admin_footer_id { nil }
  end
end
