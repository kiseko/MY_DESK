FactoryBot.define do
  factory :review do
    rating {5}
    description { Faker::Lorem.characters(number: 10) }
  end
end