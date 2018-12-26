FactoryBot.define do
  factory :system_setup, class: Admin::SystemSetup do |f|
    f.maintenance { false }
    f.landing_page_id { 1 }
    f.locale { 'en' }
    f.locale_name { 'English' }
  end
end
