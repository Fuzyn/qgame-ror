class User < ApplicationRecord
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@\s]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}\z/, message: "must be a valid email format" }
  validates :password, length: { minimum: 6 }

  has_one :user_fleet, dependent: :destroy
  has_one :user_defence, dependent: :destroy

  after_create :create_defaults

  private

  def create_defaults
    create_user_fleet!
    create_user_defence!
  end
end
