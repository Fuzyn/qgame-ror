class User < ApplicationRecord
  include UsersHelper

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}\z/, message: "must be a valid email format" }
  validates :password, length: { minimum: 6 }

  has_many :planet_fleets, dependent: :destroy
  has_many :planet_defences, dependent: :destroy
  has_many :planet_buildings, dependent: :destroy
  has_many :planets, dependent: :destroy
  has_many :build_queues, dependent: :destroy
  has_many :send_fleet_queues, dependent: :destroy
  has_one :user_technology, dependent: :destroy

  after_create :create_defaults

  private

  def create_defaults
    photo_number = 1
    galaxy = 1
    solar_system = 1
    planet_position = 1

    loop do
      photo_number = rand(1..1)

      break unless Planet.find_by(user: self, photo_number: photo_number)
    end

    loop do
      galaxy = rand(1..9)
      solar_system = rand(1..255)
      planet_position = rand(1..15)

      break unless Planet.find_by(galaxy: galaxy, solar_system: solar_system, planet_position: planet_position)
    end

    self.planets.create!(
      {
        name: Faker::Lorem.word&.capitalize,
        galaxy: galaxy,
        solar_system: solar_system,
        planet_position: planet_position,
        photo_number: photo_number
      })
    create_user_technology!
  end
end
