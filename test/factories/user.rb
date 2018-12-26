FactoryBot.define do
  factory :user do |f|
    f.name { Faker::Name.name }
    f.email { Faker::Internet.safe_email }
    f.password { Faker::Internet.password }
    f.gdpr_accepted { true }
  end
end
