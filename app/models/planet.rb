class Planet < ApplicationRecord
  include PlanetsHelper

  belongs_to :user
  has_one :planet_fleet, dependent: :destroy
  has_one :planet_defence, dependent: :destroy
  has_one :planet_building, dependent: :destroy

  after_create :create_defaults

  def increment_resources
    increment!(:metal_resource, MetalMine.production(self))
    increment!(:crystal_resource, CrystalMine.production(self))
    increment!(:deuterium_resource, DeuteriumRefinery.production(self))
  end

  private

  def create_defaults
    PlanetBuilding.create!({ user: self.user, planet_id: self.id })
    PlanetFleet.create!({ user: self.user, planet_id: self.id })
    PlanetDefence.create!({ user: self.user, planet_id: self.id })
  end
end
