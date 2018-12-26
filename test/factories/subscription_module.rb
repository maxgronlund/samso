FactoryBot.define do
  factory :subscription_module, class: Admin::SubscriptionModule do |f|
    f.title { 'Subscribe' }
    f.body { 'Subscribe to this funky content' }
  end
end
