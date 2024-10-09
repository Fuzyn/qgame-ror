require 'rails_helper'

RSpec.describe "Buildings", type: :class do
  let(:planet) { create(:planet) }

  describe "should have variables" do
    it 'relation_name' do
      expect(Buildings.relation_name).to eq("planet_building")
    end
    it 'source' do
      expect(Buildings.source).to eq("buildings")
    end
  end

  describe "production should increase" do
    it 'MetalMine' do
      expect(MetalMine.production(planet)).to eq(13)
      planet.planet_building.increment!('metal_mine', 1)
      expect(MetalMine.production(planet)).to eq(29)
    end

    it 'CrystalMine' do
      expect(CrystalMine.production(planet)).to eq(10)
      planet.planet_building.increment!('crystal_mine', 1)
      expect(CrystalMine.production(planet)).to eq(22)
    end

    it 'DeuteriumRefinery' do
      expect(DeuteriumRefinery.production(planet)).to eq(7)
      planet.planet_building.increment!('deuterium_refinery', 1)
      expect(DeuteriumRefinery.production(planet)).to eq(15)
    end

    it 'PowerStation' do
      expect(PowerStation.production(planet)).to eq(20)
      planet.planet_building.increment!('power_station', 1)
      expect(PowerStation.production(planet)).to eq(46)
    end

    it 'Buildings' do
      expect(Buildings.production(planet)).to be nil
    end
  end

  describe "energy consumption should increase" do
    it 'MetalMine' do
      expect(MetalMine.energy(planet)).to eq(0)
      planet.planet_building.increment!('metal_mine', 1)
      expect(MetalMine.energy(planet)).to eq(-3)
    end

    it 'CrystalMine' do
      expect(CrystalMine.energy(planet)).to eq(0)
      planet.planet_building.increment!('crystal_mine', 1)
      expect(CrystalMine.energy(planet)).to eq(-4)
    end

    it 'DeuteriumRefinery' do
      expect(DeuteriumRefinery.energy(planet)).to eq(0)
      planet.planet_building.increment!('deuterium_refinery', 1)
      expect(DeuteriumRefinery.energy(planet)).to eq(-6)
    end

    it 'PowerStation' do
      expect(PowerStation.energy(planet)).to eq(0)
      planet.planet_building.increment!('power_station', 1)
      expect(PowerStation.energy(planet)).to eq(0)
    end

    it 'Buildings' do
      expect(Buildings.energy(planet)).to be nil
    end
  end

  describe "should return buildings planet values" do
    it 'Buildings' do
      values = Buildings.planet_values(planet)

      values.each do |value|
        expect(value).to have_key(:points)
        expect(value).to have_key(:production)
        expect(value).to have_key(:energy_consumption)
        expect(value).to have_key(:key)
        expect(value).to have_key(:name)
        expect(value).to have_key(:description)
        expect(value).to have_key(:img)
        expect(value).to have_key(:level)
        expect(value).to have_key(:order)

        expect(value[:points]).not_to be_nil
        expect(value[:production]).not_to be_nil
        expect(value[:energy_consumption]).not_to be_nil
        expect(value[:key]).not_to be_nil
        expect(value[:name]).not_to be_nil
        expect(value[:description]).not_to be_nil
        expect(value[:img]).not_to be_nil
        expect(value[:level]).not_to be_nil
        expect(value[:order]).not_to be_nil
      end
    end

    it 'Other classes' do
      expect(MetalMine.planet_values(planet)).to eq([])
      expect(CrystalMine.planet_values(planet)).to eq([])
      expect(DeuteriumRefinery.planet_values(planet)).to eq([])
      expect(PowerStation.planet_values(planet)).to eq([])
    end
  end
end
