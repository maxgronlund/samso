FactoryBot.define do
  factory :blog_module, class: Admin::BlogModule do |f|
    f.name { nil }
    f.body { nil }
    f.layout { nil }
    f.blog_posts_count { 0 }
    f.posts_pr_page { 10 }
    f.admin_blog_id { nil }
    f.show_search { false }
  end
end
