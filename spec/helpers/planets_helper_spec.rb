require 'rails_helper'

RSpec.describe PlanetsHelper, type: :helper do
  let(:user) { create(:user) }
  let(:planet) { create(:planet, user: user, photo_number: 1) }

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

  describe 'randomize_photo_number' do
    it 'returns a random photo number between 1 and 11' do
      photo_number = helper.randomize_photo_number(user)

      expect(photo_number).to be_between(1, 11).inclusive
    end

    it 'does not return a photo number that already exists for the user' do
      existing_photo_number = planet.photo_number
      new_planet = create(:planet, user: user, photo_number: existing_photo_number)

      expect(new_planet.photo_number).to eq(existing_photo_number)
      expect(helper.randomize_photo_number(user)).not_to eq(existing_photo_number)
    end
  end

  describe 'create_random_planet' do
    it 'creates a planet with a random galaxy, solar system, and position' do
      new_planet = helper.create_random_planet(user)

      expect(new_planet.galaxy).to be_between(1, 9).inclusive
      expect(new_planet.solar_system).to be_between(1, 255).inclusive
      expect(new_planet.planet_position).to be_between(1, 15).inclusive
      expect(new_planet.photo_number).to be_between(1, 11).inclusive
    end

    it 'does not create a planet at the same galaxy, solar system, and position as an existing planet' do
      create(:planet, galaxy: 1, solar_system: 1, planet_position: 1)

      new_planet = helper.create_random_planet(user)

      expect(new_planet.galaxy).not_to eq(1)
      expect(new_planet.solar_system).not_to eq(1)
      expect(new_planet.planet_position).not_to eq(1)
    end
  end

  describe 'create_specific_planet' do
    let(:params) { { galaxy: 2, solar_system: 50, planet_position: 10 } }

    it 'creates a planet with specific parameters' do
      specific_planet = helper.create_specific_planet(user, params)

      expect(specific_planet.galaxy).to eq(2)
      expect(specific_planet.solar_system).to eq(50)
      expect(specific_planet.planet_position).to eq(10)
      expect(specific_planet.photo_number).to be_between(1, 11).inclusive
    end

    it 'assigns a random photo number that does not already exist for the user' do
      existing_planet = create(:planet, user: user, photo_number: 5)
      specific_planet = helper.create_specific_planet(user, params)

      expect(specific_planet.photo_number).not_to eq(existing_planet.photo_number)
    end
  end
end
