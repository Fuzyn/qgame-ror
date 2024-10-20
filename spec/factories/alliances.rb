FactoryBot.define do
  factory :alliance do
    name { Faker::Lorem.word&.capitalize }
    short { Faker::Lorem.characters(number: 6).upcase }
  end
end
