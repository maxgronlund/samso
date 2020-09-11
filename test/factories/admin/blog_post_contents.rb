FactoryBot.define do
  factory :admin_blog_post_content, class: 'Admin::BlogPostContent' do
    title { "MyString" }
    body { "MyText" }
    image { "MyString" }
    image_caption { "MyString" }
    position { 1 }
    admin_blog_post { nil }
  end
end
