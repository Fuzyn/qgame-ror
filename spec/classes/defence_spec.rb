require 'rails_helper'

RSpec.describe "Defences", type: :request do
  let(:planet) { create(:planet) }

  describe "should have variables" do
    it 'relation_name' do
      expect(Defence.relation_name).to eq("planet_defence")
    end
    it 'source' do
      expect(Defence.source).to eq("defence")
    end
  end

  describe "should return defences basic values" do
    it 'Defence' do
      values = Defence.basic_values

      values.each do |value|
        expect(value).to have_key(:points)
        expect(value).to have_key(:shield)
        expect(value).to have_key(:attack)
        expect(value).to have_key(:key)
        expect(value).to have_key(:name)
        expect(value).to have_key(:description)
        expect(value).to have_key(:img)
        expect(value).to have_key(:order)

        expect(value[:points]).not_to be_nil
        expect(value[:shield]).not_to be_nil
        expect(value[:attack]).not_to be_nil
        expect(value[:key]).not_to be_nil
        expect(value[:name]).not_to be_nil
        expect(value[:description]).not_to be_nil
        expect(value[:img]).not_to be_nil
        expect(value[:order]).not_to be_nil
      end
    end

    it 'Other classes' do
      expect(RocketLauncher.basic_values).to eq([])
      expect(LightLaserCannon.basic_values).to eq([])
      expect(HeavyLaserCannon.basic_values).to eq([])
      expect(LightIonCannon.basic_values).to eq([])
      expect(HeavyIonCannon.basic_values).to eq([])
    end
  end

  describe "should return defences planet values" do
    it 'Defence' do
      values = Defence.planet_values(planet)

      values.each do |value|
        expect(value).to have_key(:points)
        expect(value).to have_key(:shield)
        expect(value).to have_key(:attack)
        expect(value).to have_key(:key)
        expect(value).to have_key(:name)
        expect(value).to have_key(:description)
        expect(value).to have_key(:img)
        expect(value).to have_key(:order)

        expect(value[:points]).not_to be_nil
        expect(value[:shield]).not_to be_nil
        expect(value[:attack]).not_to be_nil
        expect(value[:key]).not_to be_nil
        expect(value[:name]).not_to be_nil
        expect(value[:description]).not_to be_nil
        expect(value[:img]).not_to be_nil
        expect(value[:order]).not_to be_nil
      end
    end

    it 'Other classes' do
      expect(RocketLauncher.planet_values(planet)).to eq([])
      expect(LightLaserCannon.planet_values(planet)).to eq([])
      expect(HeavyLaserCannon.planet_values(planet)).to eq([])
      expect(LightIonCannon.planet_values(planet)).to eq([])
      expect(HeavyIonCannon.planet_values(planet)).to eq([])
    end
  end
end
