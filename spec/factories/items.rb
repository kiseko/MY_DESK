FactoryBot.define do
  factory :item do
    brand { Faker::Lorem.characters(number: 10) }
    name { Faker::Lorem.characters(number: 10) }
  end
end