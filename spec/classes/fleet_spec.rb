require 'rails_helper'

RSpec.describe "Fleets", type: :request do
  let(:planet) { create(:planet) }

  describe "should have variables" do
    it 'relation_name' do
      expect(Fleet.relation_name).to eq("planet_fleet")
    end
    it 'source' do
      expect(Fleet.source).to eq("fleet")
    end
  end

  describe "should return fleet planet values" do
    it 'Fleet' do
      values = Fleet.planet_values(planet)

      values.each do |value|
        expect(value).to have_key(:points)
        expect(value).to have_key(:shield)
        expect(value).to have_key(:basic_shield)
        expect(value).to have_key(:attack)
        expect(value).to have_key(:basic_attack)
        expect(value).to have_key(:speed)
        expect(value).to have_key(:basic_speed)
        expect(value).to have_key(:capacity)
        expect(value).to have_key(:basic_capacity)
        expect(value).to have_key(:combustion)
        expect(value).to have_key(:basic_combustion)
        expect(value).to have_key(:key)
        expect(value).to have_key(:name)
        expect(value).to have_key(:description)
        expect(value).to have_key(:img)
        expect(value).to have_key(:order)

        expect(value[:points]).not_to be_nil
        expect(value[:shield]).not_to be_nil
        expect(value[:basic_shield]).not_to be_nil
        expect(value[:attack]).not_to be_nil
        expect(value[:basic_attack]).not_to be_nil
        expect(value[:speed]).not_to be_nil
        expect(value[:basic_speed]).not_to be_nil
        expect(value[:capacity]).not_to be_nil
        expect(value[:basic_capacity]).not_to be_nil
        expect(value[:combustion]).not_to be_nil
        expect(value[:basic_combustion]).not_to be_nil
        expect(value[:key]).not_to be_nil
        expect(value[:name]).not_to be_nil
        expect(value[:description]).not_to be_nil
        expect(value[:img]).not_to be_nil
        expect(value[:order]).not_to be_nil
      end
    end

    it 'Other classes' do
      expect(LightFighter.planet_values(planet)).to eq([])
      expect(HeavyFighter.planet_values(planet)).to eq([])
      expect(Cruiser.planet_values(planet)).to eq([])
      expect(Warship.planet_values(planet)).to eq([])
    end
  end

end
