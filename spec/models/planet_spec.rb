require 'rails_helper'

RSpec.describe Planet, type: :model do
  let(:planet) { create(:planet) }

  describe "validations" do
    context "planet limit" do
      it 'user can not have more than 14 planets' do
        user = create(:user)
        13.times { user.planets.create!({}) }

        expect(user.planets.new({})).not_to be_valid
      end
    end

    context "should have all associations" do
      it "should have user" do
        expect(planet.user).to be_valid
      end

      it "should have planet_fleet" do
        expect(planet.planet_fleet).to be_valid
      end

      it "should have planet_defence" do
        expect(planet.planet_defence).to be_valid
      end

      it "should have planet_building" do
        expect(planet.planet_building).to be_valid
      end
    end

    context "resources" do
      it 'should increase' do
        expect(planet.metal_resource).to eq(0)
        expect(planet.crystal_resource).to eq(0)
        expect(planet.deuterium_resource).to eq(0)

        planet.increment_resources

        expect(planet.metal_resource).to eq(13)
        expect(planet.crystal_resource).to eq(10)
        expect(planet.deuterium_resource).to eq(7)

        planet.increment_resources

        expect(planet.metal_resource).to eq(26)
        expect(planet.crystal_resource).to eq(20)
        expect(planet.deuterium_resource).to eq(14)
      end
    end
  end
end
