FactoryBot.define do
  factory :post do
    title        { Faker::Lorem.characters(number: 12) }
    source       { Faker::Lorem.characters(number: 12) }
    source_url   { Faker::Internet.url }
    link         { Faker::Internet.url }
    publish_date { Faker::Date.in_date_period }
    description  { Faker::Lorem.characters(number: 25) }
  end
end
