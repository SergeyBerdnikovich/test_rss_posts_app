FactoryBot.define do
  factory :feed_url do
    url { Faker::Internet.url }
  end
end
