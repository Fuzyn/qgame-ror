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
      expect(LightFighter.user_shield(user)).to eq(10)
      expect(LightIonCannon.user_shield(user)).to eq(800)
      expect(Fleet.user_shield(user)).to be nil
      expect(Defence.user_shield(user)).to be nil

      user.user_technology.increment!('protective_technology', 1)

      expect(LightFighter.user_shield(user)).to eq(10.3)
      expect(LightIonCannon.user_shield(user)).to eq(824)
      expect(Fleet.user_shield(user)).to be nil
      expect(Defence.user_shield(user)).to be nil
    end

    it 'basic_attack' do
      expect(HeavyFighter.basic_attack).to eq(60)
      expect(RocketLauncher.basic_attack).to eq(100)
      expect(Fleet.basic_attack).to be nil
      expect(Defence.basic_attack).to be nil
    end

    it 'user_attack' do
      expect(HeavyFighter.user_attack(user)).to eq(60)
      expect(RocketLauncher.user_attack(user)).to eq(100)
      expect(Fleet.user_attack(user)).to be nil
      expect(Defence.user_attack(user)).to be nil

      user.user_technology.increment!('combat_technology', 1)

      expect(HeavyFighter.user_attack(user)).to eq(63.6)
      expect(RocketLauncher.user_attack(user)).to eq(106)
      expect(Fleet.user_attack(user)).to be nil
      expect(Defence.user_attack(user)).to be nil
    end

    it 'basic_speed' do
      expect(Cruiser.basic_speed).to eq(200)
      expect(HeavyIonCannon.basic_speed).to be nil
      expect(Fleet.basic_speed).to be nil
      expect(Defence.basic_speed).to be nil
    end

    it 'user_speed' do
      expect(Cruiser.user_speed(user)).to eq(200)
      expect(HeavyIonCannon.user_speed(user)).to be nil
      expect(Fleet.user_speed(user)).to be nil
      expect(Defence.user_speed(user)).to be nil

      user.user_technology.increment!('drive_technology', 1)

      expect(Cruiser.user_speed(user)).to eq(212)
      expect(HeavyIonCannon.user_speed(user)).to be nil
      expect(Fleet.user_speed(user)).to be nil
      expect(Defence.user_speed(user)).to be nil
    end

    it 'basic_capacity' do
      expect(Warship.basic_capacity).to eq(6000)
      expect(HeavyIonCannon.basic_capacity).to be nil
      expect(Fleet.basic_capacity).to be nil
      expect(Defence.basic_capacity).to be nil
    end

    it 'user_capacity' do
      expect(Warship.user_capacity(user)).to eq(6000)
      expect(HeavyIonCannon.user_capacity(user)).to be nil
      expect(Fleet.user_capacity(user)).to be nil
      expect(Defence.user_capacity(user)).to be nil

      user.user_technology.increment!('storage_technology', 1)

      expect(Warship.user_capacity(user)).to eq(6120)
      expect(HeavyIonCannon.user_capacity(user)).to be nil
      expect(Fleet.user_capacity(user)).to be nil
      expect(Defence.user_capacity(user)).to be nil
    end

    it 'basic_combustion' do
      expect(LightFighter.basic_combustion).to eq(10)
      expect(HeavyIonCannon.basic_combustion).to be nil
      expect(Fleet.basic_combustion).to be nil
      expect(Defence.basic_combustion).to be nil
    end

    it 'user_combustion' do
      expect(LightFighter.user_combustion(user)).to eq(10)
      expect(HeavyIonCannon.user_combustion(user)).to be nil
      expect(Fleet.user_combustion(user)).to be nil
      expect(Defence.user_combustion(user)).to be nil

      user.user_technology.increment!('drive_technology', 1)

      expect(LightFighter.user_combustion(user)).to eq(9.6)
      expect(HeavyIonCannon.user_combustion(user)).to be nil
      expect(Fleet.user_combustion(user)).to be nil
      expect(Defence.user_combustion(user)).to be nil
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
