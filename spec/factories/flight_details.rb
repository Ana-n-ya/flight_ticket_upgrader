FactoryBot.define do
  factory :flight_detail_alt do
    first_name { "John" }
    last_name { "Doe" }
    pnr { "AB123" }
    fare_class { "Economy" }
    travel_date { Date.today }
    pax { 1 }
    ticketing_date { Date.today }
    email { "john.doe@example.com" }
    mobile_phone { "1234567890" }
  end

  factory :flight_detail_alt2 do
    first_name { "Jane" }
    last_name { "Doe" }
    pnr { "DEF456" }
    fare_class { "Business" }
    travel_date { Date.today }
    pax { 2 }
    ticketing_date { Date.today }
    email { "jane.doe@example.com" }
    mobile_phone { "0987654321" }
  end
end
