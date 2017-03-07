FactoryGirl.define do
  factory :restaurant do
    name                { Faker::App.name }
    address             { Faker::Address.street_address }
    max_delivery_time   { Faker::Number.digit }
    cuisine             { 'American' }
    accepts_10bis       true
  end

  factory :review do
    name                { Faker::Name.name }
    rating              { Faker::Number.digit }
    comment             { Faker::Lorem.sentence}
    association :restaurant, factory: :restaurant
  end
end