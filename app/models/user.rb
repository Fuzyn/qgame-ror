class User < ApplicationRecord
  include UsersHelper
  include NotificationHelper
  include PlanetsHelper

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}\z/, message: "must be a valid email format" }
  validates :password, length: { minimum: 6 }

  has_many :planet_fleets, dependent: :destroy
  has_many :planet_defences, dependent: :destroy
  has_many :planet_buildings, dependent: :destroy
  has_many :planets, dependent: :destroy
  has_many :build_queues, dependent: :destroy
  has_many :send_fleet_queues, dependent: :destroy
  has_many :user_messages, dependent: :destroy
  has_one :user_technology, dependent: :destroy

  after_create :create_defaults

  private

  def create_defaults
    create_random_planet(self)
    create_message(self, "Welcome aboard", "Welcome to the new QGame", UserMessage::INITIAL_KEY)
    create_user_technology!
  end
end
