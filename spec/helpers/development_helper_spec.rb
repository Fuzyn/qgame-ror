require 'rails_helper'

RSpec.describe DevelopmentHelper, type: :helper do
  let(:user) { create(:user) }
  let(:planet) { user.planets.first }

  describe "Basic functions" do
    it 'calculated_degree_growth' do
      expect(MetalMine.calculated_degree_growth(planet)).to eq(0)
      planet.planet_building.increment!('metal_mine', 1)
      expect(MetalMine.calculated_degree_growth(planet)).to eq(1.3)
      planet.planet_building.increment!('metal_mine', 1)
      expect(MetalMine.calculated_degree_growth(planet)).to eq(1.69)

      expect(CrystalMine.calculated_degree_growth(planet)).to eq(0)
      planet.planet_building.increment!('crystal_mine', 1)
      expect(CrystalMine.calculated_degree_growth(planet)).to eq(1.2)
      planet.planet_building.increment!('crystal_mine', 1)
      expect(CrystalMine.calculated_degree_growth(planet)).to eq(1.44)

      expect(Buildings.calculated_degree_growth(planet)).to eq(0)

      expect(RocketTechnology.calculated_degree_growth(user)).to eq(1)
      user.user_technology.increment!('rocket_technology', 1)
      expect(RocketTechnology.calculated_degree_growth(user)).to eq(1.04)
      user.user_technology.increment!('rocket_technology', 1)
      expect(RocketTechnology.calculated_degree_growth(user)).to eq(1.08)
    end

    it 'calculated_degree_drop' do
      expect(IonTechnology.calculated_degree_drop(user)).to eq(1)
      user.user_technology.increment!('ion_technology', 1)
      expect(IonTechnology.calculated_degree_drop(user)).to eq(0.99)
      user.user_technology.increment!('ion_technology', 1)
      expect(IonTechnology.calculated_degree_drop(user)).to eq(0.98)

      expect(ProtectiveTechnology.calculated_degree_drop(user)).to eq(1)
      user.user_technology.increment!('protective_technology', 1)
      expect(ProtectiveTechnology.calculated_degree_drop(user)).to eq(0.99)
      user.user_technology.increment!('protective_technology', 1)
      expect(ProtectiveTechnology.calculated_degree_drop(user)).to eq(0.98)

      expect(Technology.calculated_degree_drop(user)).to eq(1)
    end

    it 'planet_development_sum_points' do
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
