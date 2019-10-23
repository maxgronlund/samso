FactoryBot.define do
  factory :text_module, class: Admin::TextModule do |f|
    f.title { Faker::Hipster.sentence(word_count: 3) }
    f.body { Faker::Hipster.sentence(word_count: 16) }
    f.url { '' }
    f.url_text { nil }
    f.page_id { nil }
    f.color { '#000000' }
    f.background_color { '#FFFFFF' }
    f.border { false }
    f.image_style { 'full-width' }
    f.link_layout { 'text' }
    f.image_ratio { '2_1' }
    f.image_file_name { nil }
    f.image_content_type { nil }
    f.image_file_size { nil }
    f.image_updated_at { nil }
  end
end
