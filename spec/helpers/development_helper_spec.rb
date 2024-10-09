require 'rails_helper'

RSpec.describe DevelopmentHelper, type: :helper do
  let(:user) { create(:user) }
  let(:planet) { user.planets.first }

  describe "Basic functions" do
    it 'calculated_degree' do
      expect(MetalMine.calculated_degree(planet)).to eq(0)
      planet.planet_building.increment!('metal_mine', 1)
      expect(MetalMine.calculated_degree(planet)).to eq(1.3)
      planet.planet_building.increment!('metal_mine', 1)
      expect(MetalMine.calculated_degree(planet)).to eq(1.69)

      expect(CrystalMine.calculated_degree(planet)).to eq(0)
      planet.planet_building.increment!('crystal_mine', 1)
      expect(CrystalMine.calculated_degree(planet)).to eq(1.2)
      planet.planet_building.increment!('crystal_mine', 1)
      expect(CrystalMine.calculated_degree(planet)).to eq(1.44)

      expect(Buildings.calculated_degree(planet)).to eq(0)
    end

    it 'calculated_degree' do
      expect(Buildings.planet_development_sum_points(planet)).to eq(0)
      expect(MetalMine.planet_development_sum_points(planet)).to eq(0)
      expect(CrystalMine.planet_development_sum_points(planet)).to eq(0)
      expect(DeuteriumRefinery.planet_development_sum_points(planet)).to eq(0)
      expect(PowerStation.planet_development_sum_points(planet)).to eq(0)

      planet.planet_building.increment!('metal_mine', 1)

      expect(Buildings.planet_development_sum_points(planet)).to eq(520)
      expect(MetalMine.planet_development_sum_points(planet)).to eq(0)
      expect(CrystalMine.planet_development_sum_points(planet)).to eq(0)
      expect(DeuteriumRefinery.planet_development_sum_points(planet)).to eq(0)
      expect(PowerStation.planet_development_sum_points(planet)).to eq(0)

      planet.planet_building.increment!('metal_mine', 1)

      expect(Buildings.planet_development_sum_points(planet)).to eq(676)
      expect(MetalMine.planet_development_sum_points(planet)).to eq(0)
      expect(CrystalMine.planet_development_sum_points(planet)).to eq(0)
      expect(DeuteriumRefinery.planet_development_sum_points(planet)).to eq(0)
      expect(PowerStation.planet_development_sum_points(planet)).to eq(0)

      planet.planet_building.increment!('crystal_mine', 1)

      expect(Buildings.planet_development_sum_points(planet)).to eq(1276)
      expect(MetalMine.planet_development_sum_points(planet)).to eq(0)
      expect(CrystalMine.planet_development_sum_points(planet)).to eq(0)
      expect(DeuteriumRefinery.planet_development_sum_points(planet)).to eq(0)
      expect(PowerStation.planet_development_sum_points(planet)).to eq(0)
    end
  end
end
