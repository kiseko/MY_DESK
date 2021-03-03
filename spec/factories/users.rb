FactoryBot.define do
  factory :user do
    unique_name { Faker::Lorem.characters(number: 10) }
    hundle_name { Faker::Lorem.characters(number: 10) }
    introduction { Faker::Lorem.characters(number: 20) }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end