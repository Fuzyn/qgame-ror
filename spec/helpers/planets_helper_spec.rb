require 'rails_helper'

RSpec.describe PlanetsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:planet) { user.planets.first }

  describe "Basic functions" do
    it 'planet_energy_balance' do
      expect(planet.planet_energy_balance).to eq(20)

      planet.planet_building.increment!('power_station', 1)
      expect(planet.planet_energy_balance).to eq(46)

      planet.planet_building.increment!('metal_mine', 1)
      expect(planet.planet_energy_balance).to eq(43)

      planet.planet_building.increment!('crystal_mine', 1)
      expect(planet.planet_energy_balance).to eq(39)
    end

    it 'planet_sum_points' do
      expect(planet.planet_sum_points).to eq(0)

      planet.planet_defence.increment!('rocket_launcher', 8)
      planet.planet_defence.increment!('heavy_ion_cannon', 1)
      planet.planet_fleet.increment!('heavy_fighter', 2)
      planet.planet_fleet.increment!('light_fighter', 2)
      planet.planet_building.increment!('metal_mine', 1)
      planet.planet_building.increment!('crystal_mine', 1)

      expect(planet.planet_sum_points).to eq(27120)

      planet.planet_building.increment!('metal_mine', 1)

      expect(planet.planet_sum_points).to eq(27276)
    end
  end
end
