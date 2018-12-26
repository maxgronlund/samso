FactoryBot.define do
  factory :subscription, class: Admin::Subscription do |f|
    f.user_id { 1 }
    f.subscription_type_id { 1 }
    f.start_date { Time.zone.now.to_datetime - 1.day }
    f.end_date { Time.zone.now.to_datetime + 13.days }
  end
end
