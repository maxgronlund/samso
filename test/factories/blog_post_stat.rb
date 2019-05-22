FactoryBot.define do
  factory :blog_post_stat, class: BlogPostStat do |f|
    f.views { 1 }
    f.admin_blog_post_id { nil }
    f.start_date { Time.zone.now - 1.day }
  end
end
