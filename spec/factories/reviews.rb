FactoryBot.define do
  factory :review do
    introduction { Faker::Lorem.characters(number: 10) }
  end
end