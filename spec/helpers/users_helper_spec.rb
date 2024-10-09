require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user) { create(:user) }
  let(:planet) { user.planets.first }

  describe "Basic functions" do
    it 'user_sum_points' do
      expect(user.user_sum_points).to eq(0)

      planet.planet_defence.increment!('rocket_launcher', 4)
      planet.planet_defence.increment!('heavy_ion_cannon', 2)
      planet.planet_fleet.increment!('heavy_fighter', 2)
      planet.planet_fleet.increment!('light_fighter', 2)
      planet.planet_building.increment!('metal_mine', 1)
      planet.planet_building.increment!('crystal_mine', 1)

      expect(user.user_sum_points).to eq(33120)

      planet.planet_building.increment!('metal_mine', 1)

      expect(user.user_sum_points).to eq(33276)
    end
  end
end
