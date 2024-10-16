FactoryBot.define do
  factory :send_fleet_queue do
    association :user
    association :planet

    user_email { user.email }
    travel_type { %w[transport attack spy expedition colonize].sample }
    galaxy { rand(1..9) }
    solar_system { rand(1..255) }
    planet_position { rand(1..15) }
    cruiser { rand(1..50) }
    light_fighter { rand(1..50) }
    heavy_fighter { rand(1..50) }
    warship { rand(1..50) }
    metal_resource { rand(100..1000) }
    crystal_resource { rand(100..1000) }
    deuterium_resource { rand(100..1000) }
    end_time { Time.now + 10.minutes }
    secret_hash { SecureRandom.hex(10) }
    direction { %w[to from].sample }
    deleted { false }
  end
end