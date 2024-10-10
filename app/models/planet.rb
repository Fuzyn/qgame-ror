class Planet < ApplicationRecord
  include PlanetsHelper

  belongs_to :user
  has_one :planet_fleet, dependent: :destroy
  has_one :planet_defence, dependent: :destroy
  has_one :planet_building, dependent: :destroy

  validate :max_planets_limit, on: :create
  after_create :create_defaults

  def increment_resources
    increment!(:metal_resource, MetalMine.production(self))
    increment!(:crystal_resource, CrystalMine.production(self))
    increment!(:deuterium_resource, DeuteriumRefinery.production(self))

    broadcast_replace_later_to "planet_#{self.id}", locals: { planet: self }
  end

  private

  def max_planets_limit
    user = self.user
    if user.planets.size >= 14
      errors.add(:base, 'You can make max 14 planet.')
    end
  end

  def create_defaults
    PlanetBuilding.create!({ user: self.user, planet_id: self.id })
    PlanetFleet.create!({ user: self.user, planet_id: self.id })
    PlanetDefence.create!({ user: self.user, planet_id: self.id })
  end
end
