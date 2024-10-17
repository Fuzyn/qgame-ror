class ResourcesController < ApplicationController
  def index
    planet = current_planet

    @metal_production = MetalMine.production(planet)
    @crystal_production = CrystalMine.production(planet)
    @deuterium_production = DeuteriumRefinery.production(planet)
    @station_production = PowerStation.production(planet)

    @metal_energy = MetalMine.energy(planet)
    @crystal_energy = CrystalMine.energy(planet)
    @deuterium_energy = DeuteriumRefinery.energy(planet)

    @energy_balance = planet&.planet_energy_balance
  end
end
