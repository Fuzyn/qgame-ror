class User < ApplicationRecord
  include UsersHelper

  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}\z/, message: "must be a valid email format" }
  validates :password, length: { minimum: 6 }

  has_one :user_fleet, dependent: :destroy
  has_one :user_defence, dependent: :destroy
  has_one :user_building, dependent: :destroy

  after_create :create_defaults

  def increment_resources
    increment!(:metal_resource, MetalMine.production(self))
    increment!(:crystal_resource, CrystalMine.production(self))
    increment!(:deuterium_resource, DeuteriumRefinery.production(self))
  end

  private

  def create_defaults
    create_user_fleet!
    create_user_defence!
    create_user_building!
  end
end
