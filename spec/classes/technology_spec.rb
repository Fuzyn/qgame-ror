require 'rails_helper'

RSpec.describe "Technology", type: :class do
  let(:user) { create(:user) }

  describe "should have variables" do
    it 'relation_name' do
      expect(Technology.relation_name).to eq("user_technology")
    end
    it 'source' do
      expect(Technology.source).to eq("technology")
    end
  end

  describe "should return correct value" do
    it 'calculated_degree_growth' do
      expect(EnergyTechnology.calculated_degree_growth(user)).to eq(1)
      user.user_technology.increment!('energy_technology', 1)
      expect(EnergyTechnology.calculated_degree_growth(user)).to eq(1.03)
    end

    it 'calculated_degree_growth' do
      expect(EnergyTechnology.calculated_degree_drop(user)).to eq(1)
      user.user_technology.increment!('energy_technology', 1)
      expect(EnergyTechnology.calculated_degree_drop(user)).to eq(0.98)
    end
  end

  describe "should return technology user values" do
    it 'Technology' do
      values = Technology.user_values(user)

      values.each do |value|
        expect(value).to have_key(:points)
        expect(value).to have_key(:degree_growth)
        expect(value).to have_key(:degree_drop)
        expect(value).to have_key(:key)
        expect(value).to have_key(:name)
        expect(value).to have_key(:description)
        expect(value).to have_key(:img)
        expect(value).to have_key(:level)
        expect(value).to have_key(:order)

        expect(value[:points]).not_to be_nil
        expect(value[:degree_growth]).not_to be_nil
        expect(value[:degree_drop]).not_to be_nil
        expect(value[:key]).not_to be_nil
        expect(value[:name]).not_to be_nil
        expect(value[:description]).not_to be_nil
        expect(value[:img]).not_to be_nil
        expect(value[:level]).not_to be_nil
        expect(value[:order]).not_to be_nil
      end
    end

    it 'Other classes' do
      expect(CombatTechnology.user_values(user)).to eq([])
      expect(CombustionDrive.user_values(user)).to eq([])
      expect(DriveTechnology.user_values(user)).to eq([])
      expect(EnergyTechnology.user_values(user)).to eq([])
      expect(HyperspaceDrive.user_values(user)).to eq([])
      expect(ImpulseDrive.user_values(user)).to eq([])
      expect(IonTechnology.user_values(user)).to eq([])
      expect(LaserTechnology.user_values(user)).to eq([])
      expect(PlasmaTechnology.user_values(user)).to eq([])
      expect(ProtectiveTechnology.user_values(user)).to eq([])
      expect(RocketTechnology.user_values(user)).to eq([])
      expect(StorageTechnology.user_values(user)).to eq([])
    end
  end
end
