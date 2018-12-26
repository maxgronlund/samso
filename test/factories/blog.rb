FactoryBot.define do
  factory :blog, class: Admin::Blog do |f|
    f.title { generate(:blog_title) }
    f.locale { 'en' }
    f.show_page_id { 1 }
    f.index_page_id { 1 }
  end
end
