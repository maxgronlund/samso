FactoryBot.define do
  factory :subscription_type, class: Admin::SubscriptionType do |f|
    f.title { 'Internet access' }
    f.body { 'Read all articles online' }
    f.internet_version { true }
    f.print_version { true }
    f.price { 50.0 }
    f.locale { 'en' }
    f.active { true }
    f.duration { 90 }
    f.position { 0 }
  end
end
