FactoryBot.define do
  factory :role, class: Role do |f|
    f.permission { Role::MEMBER }
    f.active { true }
    f.user_id { 1 }
  end
end
