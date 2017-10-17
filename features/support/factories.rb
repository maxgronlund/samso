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
    f.require_subscription false
    f.background_color 'none'
    f.cache_page false
    f.user_id 0
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
end
