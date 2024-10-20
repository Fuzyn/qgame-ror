FactoryBot.define do
  factory :user_message do
    association :user
    title { Faker::Lorem.word&.capitalize }
    message { Faker::Lorem.sentence }
    message_type { UserMessage::INITIAL_KEY }

    trait :initial do
      message_type { UserMessage::INITIAL_KEY }
      title { UserMessage::INITIAL_TITLE }
    end

    trait :transport do
      message_type { UserMessage::TRANSPORT_KEY }
      title { UserMessage::TRANSPORT_TITLE }
    end

    trait :attack do
      message_type { UserMessage::ATTACK_KEY }
      title { UserMessage::ATTACK_TITLE }
    end

    trait :spy do
      message_type { UserMessage::SPY_KEY }
      title { UserMessage::SPY_TITLE }
    end

    trait :expedition do
      message_type { UserMessage::EXPEDITION_KEY }
      title { UserMessage::EXPEDITION_TITLE }
    end

    trait :colonize do
      message_type { UserMessage::COLONIZE_KEY }
      title { UserMessage::COLONIZE_TITLE }
    end
  end
end
