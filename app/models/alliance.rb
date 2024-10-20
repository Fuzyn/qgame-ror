class Alliance < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :short, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 6 }
end
