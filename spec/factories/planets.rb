FactoryBot.define do
  factory :planet do
    name { Faker::Lorem.word&.capitalize }
    galaxy { Faker::Number.between(from: 1, to: 9) }
    solar_system { Faker::Number.between(from: 1, to: 255) }
    planet_position { Faker::Number.between(from: 1, to: 15) }
    photo_number { Faker::Number.between(from: 1, to: 1) }
    association :user
  end
end