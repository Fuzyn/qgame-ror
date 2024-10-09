require 'rails_helper'

RSpec.describe FleetDefenceHelper, type: :helper do
  let(:user) { create(:user) }
  let(:planet) { user.planets.first }

  describe "Basic functions" do
    it 'basic_shield' do
      expect(LightFighter.basic_shield).to eq(10)
      expect(LightIonCannon.basic_shield).to eq(800)
      expect(Fleet.basic_shield).to be nil
      expect(Defence.basic_shield).to be nil
    end

    it 'user_shield' do
      expect(LightFighter.user_shield).to eq(20)
      expect(LightIonCannon.user_shield).to eq(1600)
      expect(Fleet.user_shield).to be nil
      expect(Defence.user_shield).to be nil
    end

    it 'basic_attack' do
      expect(HeavyFighter.basic_attack).to eq(60)
      expect(RocketLauncher.basic_attack).to eq(100)
      expect(Fleet.basic_attack).to be nil
      expect(Defence.basic_attack).to be nil
    end

    it 'user_attack' do
      expect(HeavyFighter.user_attack).to eq(120)
      expect(RocketLauncher.user_attack).to eq(200)
      expect(Fleet.user_attack).to be nil
      expect(Defence.user_attack).to be nil
    end

    it 'basic_speed' do
      expect(Cruiser.basic_speed).to eq(200)
      expect(HeavyIonCannon.basic_speed).to be nil
      expect(Fleet.basic_speed).to be nil
      expect(Defence.basic_speed).to be nil
    end

    it 'user_speed' do
      expect(Cruiser.user_speed).to eq(400)
      expect(HeavyIonCannon.user_speed).to be nil
      expect(Fleet.user_speed).to be nil
      expect(Defence.user_speed).to be nil
    end

    it 'basic_capacity' do
      expect(Warship.basic_capacity).to eq(6000)
      expect(HeavyIonCannon.basic_capacity).to be nil
      expect(Fleet.basic_capacity).to be nil
      expect(Defence.basic_capacity).to be nil
    end

    it 'user_capacity' do
      expect(Warship.user_capacity).to eq(12000)
      expect(HeavyIonCannon.user_capacity).to be nil
      expect(Fleet.user_capacity).to be nil
      expect(Defence.user_capacity).to be nil
    end

    it 'basic_combustion' do
      expect(LightFighter.basic_combustion).to eq(10)
      expect(HeavyIonCannon.basic_combustion).to be nil
      expect(Fleet.basic_combustion).to be nil
      expect(Defence.basic_combustion).to be nil
    end

    it 'user_combustion' do
      expect(LightFighter.user_combustion).to eq(20)
      expect(HeavyIonCannon.user_combustion).to be nil
      expect(Fleet.user_combustion).to be nil
      expect(Defence.user_combustion).to be nil
    end

    it 'planet_equipment_sum_points' do
      expect(LightFighter.planet_equipment_sum_points(planet)).to eq(0)
      expect(HeavyIonCannon.planet_equipment_sum_points(planet)).to eq(0)
      expect(Fleet.planet_equipment_sum_points(planet)).to eq(0)
      expect(Defence.planet_equipment_sum_points(planet)).to eq(0)

      planet.planet_fleet.increment!('light_fighter', 1)

      expect(LightFighter.planet_equipment_sum_points(planet)).to eq(0)
      expect(HeavyIonCannon.planet_equipment_sum_points(planet)).to eq(0)
      expect(Fleet.planet_equipment_sum_points(planet)).to eq(1000)
      expect(Defence.planet_equipment_sum_points(planet)).to eq(0)

      planet.planet_fleet.increment!('light_fighter', 2)

      expect(LightFighter.planet_equipment_sum_points(planet)).to eq(0)
      expect(HeavyIonCannon.planet_equipment_sum_points(planet)).to eq(0)
      expect(Fleet.planet_equipment_sum_points(planet)).to eq(3000)
      expect(Defence.planet_equipment_sum_points(planet)).to eq(0)

      planet.planet_fleet.increment!('heavy_fighter', 2)

      expect(LightFighter.planet_equipment_sum_points(planet)).to eq(0)
      expect(HeavyIonCannon.planet_equipment_sum_points(planet)).to eq(0)
      expect(Fleet.planet_equipment_sum_points(planet)).to eq(9000)
      expect(Defence.planet_equipment_sum_points(planet)).to eq(0)

      planet.planet_defence.increment!('heavy_ion_cannon', 1)

      expect(LightFighter.planet_equipment_sum_points(planet)).to eq(0)
      expect(HeavyIonCannon.planet_equipment_sum_points(planet)).to eq(0)
      expect(Fleet.planet_equipment_sum_points(planet)).to eq(9000)
      expect(Defence.planet_equipment_sum_points(planet)).to eq(10000)

      planet.planet_defence.increment!('heavy_ion_cannon', 2)

      expect(LightFighter.planet_equipment_sum_points(planet)).to eq(0)
      expect(HeavyIonCannon.planet_equipment_sum_points(planet)).to eq(0)
      expect(Fleet.planet_equipment_sum_points(planet)).to eq(9000)
      expect(Defence.planet_equipment_sum_points(planet)).to eq(30000)

      planet.planet_defence.increment!('rocket_launcher', 8)

      expect(LightFighter.planet_equipment_sum_points(planet)).to eq(0)
      expect(HeavyIonCannon.planet_equipment_sum_points(planet)).to eq(0)
      expect(Fleet.planet_equipment_sum_points(planet)).to eq(9000)
      expect(Defence.planet_equipment_sum_points(planet)).to eq(38000)
    end
  end
end
