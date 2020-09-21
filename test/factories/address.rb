FactoryBot.define do
  factory :address, class: Address do |f|
    f.addressable_type {"SomeType"}
    f.addressable_id {1}
    f.name {"Some Name"}
    f.address {"Some Street"}
    f.zipp_code {"8000"}
    f.city {"Aarhus"}
    f.address_type {"primary_address"}
    f.start_date  { Time.zone.now}
    f.end_date  { Time.zone.now + 100.days }
    f.country {"Denmark"}
    f.first_name {"Some"}
    f.middle_name {"Middle"}
    f.last_name {"Last name"}
    f.street_name {"Some street name"}
    f.house_number {1234}
    f.letter {"A"}
    f.floor {"st"}
    f.side {"til v"}
  end
end
