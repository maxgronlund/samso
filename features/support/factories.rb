FactoryGirl.define do
  factory :user do |f|
    f.name 'testuser'
    f.email 'JeffreyJHuddleston@jourrapide.com'
    f.password 'BeebBeeb'
  end

  factory :page do |f|
    f.title 'Front page'
    f.menu_id 'not_in_any_menus'
    f.menu_position 0
    f.active true
    f.locale 'en'
    f.background_color 'none'
    f.cache_page false
    f.body_background_file_name nil
    f.body_background_content_type nil
    f.body_background_file_size nil
    f.body_background_updated_at nil
    f.admin_footer_id nil
  end

  factory :system_setup, class: Admin::SystemSetup do |f|
    f.maintenance false
    f.landing_page_id 1
    f.locale 'en'
    f.locale_name 'English'
  end

  factory :system_message, class: Admin::SystemMessage do |f|
    f.title 'welcome'
    f.locale 'en'
    f.identifier 'welcome'
  end

  factory :subscription_type, class: Admin::SubscriptionType do |f|
    f.title 'Internet access'
    f.body 'Read all articles online'
    f.internet_version true
    f.print_version true
    f.price 50.0
    f.locale 'en'
    f.active true
    f.duration 90
    f.position 0
  end

  factory :subscription, class: Admin::Subscription do |f|
    f.user_id 1
    f.subscription_type_id 1
    f.start_date Time.zone.now.to_datetime - 1.day
    f.end_date Time.zone.now.to_datetime + 13.days
  end

  factory :subscription_module, class: Admin::SubscriptionModule do |f|
    f.title 'Subscripe'
    f.body 'Subscribe to this funky content'
  end

  factory :blog, class: Admin::Blog do |f|
    f.title 'Blog'
    f.locale 'en'
  end

  factory :blog_post, class: Admin::BlogPost do |f|
    f.legacy_id nil
    f.title 'I noticed your band is on the roster'
    f.subtitle nil
    f.teaser nil
    f.body "Calm down, Marty. I didn't disintegrate anything. The molecular structure of both Einstein and the car are completely intact."
    f.position nil
    f.blog_id 1
    f.start_date nil
    f.end_date nil
    f.user_id 1
    f.image_file_name nil
    f.image_content_type nil
    f.image_file_size nil
    f.image_updated_at nil
  end

  factory :blog_module, class: Admin::BlogModule do |f|
    f.name nil
    f.body nil
    f.layout nil
    f.post_page_id nil
    f.blog_posts_count 0
    f.posts_pr_page 10
    f.admin_blog_id nil
  end

  factory :text_module, class: Admin::TextModule do |f|
    f.title Faker::Hipster.sentence(3)
    f.body Faker::Hipster.sentence(16)
    f.url ''
    f.url_text nil
    f.page_id nil
    f.color '#000000'
    f.background_color '#FFFFFF'
    f.border false
    f.image_style 'full-width'
    f.link_layout 'text'
    f.image_ratio '2_1'
    f.image_file_name nil
    f.image_content_type nil
    f.image_file_size nil
    f.image_updated_at nil
  end
end
