require 'rails_helper'

RSpec.describe SendFleetHelper, type: :helper do
  describe "Basic functions" do
    context 'select_options' do
      it 'returns transport, attack, and spy options for enemy planet' do
        options = helper.select_options(true, true, false)
        expect(options).to match_array([
                                         { value: 'attack', label: 'Attack' },
                                         { value: 'spy', label: 'Spy' },
                                         { value: 'transport', label: 'Transport' }
                                       ])
      end

      it 'returns only transport for friendly planet' do
        options = helper.select_options(true, false, false)
        expect(options).to match_array([{ value: 'transport', label: 'Transport' }])
      end

      it 'returns colonize option for unexplored planet' do
        options = helper.select_options(false, false, false)
        expect(options).to match_array([{ value: 'colonize', label: 'Colonize' }])
      end

      it 'returns expedition option for expedition' do
        options = helper.select_options(false, false, true)
        expect(options).to match_array([{ value: 'expedition', label: 'Expedition' }])
      end
    end

    context 'planet_ships' do
      let(:planet) { create(:planet) }

      it 'returns a list of ships with their counts and associated data' do
        planet.planet_fleet.update(light_fighter: 5, cruiser: 3)

        ships = helper.planet_ships(planet)
        expect(ships).to match_array([{:count=>5, :img=>"fleet/light_fighter.png", :key=>"light_fighter", :name=>"Light Fighter"}, {:count=>3, :img=>"fleet/cruiser.png", :key=>"cruiser", :name=>"Cruiser"}])

        planet.planet_fleet.update_attribute(:light_fighter, 2)
        planet.planet_fleet.update_attribute(:warship, 1)

        ships = helper.planet_ships(planet)
        expect(ships).to match_array([{:count=>2, :img=>"fleet/light_fighter.png", :key=>"light_fighter", :name=>"Light Fighter"}, {:count=>3, :img=>"fleet/cruiser.png", :key=>"cruiser", :name=>"Cruiser"}, {:count=>1, :img=>"fleet/warship.png", :key=>"warship", :name=>"Warship"}])
      end
    end

    context 'add_fleet_to_queue' do
      let(:user) { create(:user) }
      let(:planet) { user.planets.first }
      let(:fleet) { planet.planet_fleet }
      let(:valid_params) do
        {
          galaxy: planet.galaxy,
          solar_system: planet.solar_system,
          planet_position: planet.planet_position,
          travel_type: 'transport',
          cruiser: 2,
          light_fighter: 5,
          heavy_fighter: 1,
          warship: 1,
          metal_resource: 500,
          crystal_resource: 300,
          deuterium_resource: 200
        }
      end

      before do
        fleet.update_attribute(:cruiser, 5)
        fleet.update_attribute(:light_fighter, 10)
        fleet.update_attribute(:heavy_fighter, 3)
        fleet.update_attribute(:warship, 2)

        planet.update_attribute(:metal_resource, 1000)
        planet.update_attribute(:crystal_resource, 1000)
        planet.update_attribute(:deuterium_resource, 1000)
      end

      it 'creates a new SendFleetQueue and deducts resources from fleet and planet' do
        expect {
          helper.add_fleet_to_queue(valid_params, user, planet)
        }.to change(SendFleetQueue, :count).by(1)

        new_fleet = SendFleetQueue.last
        expect(new_fleet.user).to eq(user)
        expect(new_fleet.planet).to eq(planet)
        expect(new_fleet.cruiser).to eq(2)
        expect(new_fleet.light_fighter).to eq(5)

        fleet.reload
        expect(fleet.cruiser).to eq(3)
        expect(fleet.light_fighter).to eq(5)
        expect(fleet.warship).to eq(1)

        planet.reload
        expect(planet.metal_resource).to eq(500)
        expect(planet.crystal_resource).to eq(700)
        expect(planet.deuterium_resource).to eq(800)
      end
    end
  end
end
