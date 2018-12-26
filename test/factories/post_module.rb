FactoryBot.define do
  factory :post_module, class: Admin::PostModule do |f|
    f.name { Faker::Name.name }
  end
end
