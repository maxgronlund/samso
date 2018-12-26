FactoryBot.define do
  factory :system_message, class: Admin::SystemMessage do |f|
    f.title { 'welcome' }
    f.locale { 'en' }
    f.identifier { 'welcome' }
  end
end
