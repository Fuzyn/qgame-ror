require 'rails_helper'

RSpec.describe GalaxyController, type: :controller do
  let(:user) { create(:user) }
  let(:planet) { create(:planet, user: user, galaxy: 1, solar_system: 1, planet_position: 5) }
  let(:enemy_user) { create(:user) }
  let(:enemy_planet) { create(:planet, user: enemy_user, galaxy: 1, solar_system: 1, planet_position: 10) }

  before do
    session[:user_id] = user.id
    session[:planet_id] = planet.id
  end

  describe 'GET method: index' do
    before do
      get :index, params: { galaxy: 1, solar_system: 1 }
    end

    it 'assigns planets correctly in the solar system' do
      expect(assigns(:planets)[planet.planet_position - 1]).to eq(planet)
    end

    it 'fills remaining positions with nil' do
      expect(assigns(:planets)[0..3]).to all(be_nil)
      expect(assigns(:planets)[5..14]).to all(be_nil)
    end

    it 'adds "Unexplored territories" as the 16th element' do
      expect(assigns(:planets).last.name).to eq('Unexplored territories')
    end
  end

  describe 'POST method: add_fleet' do
    before {
      fleet = planet.planet_fleet
      fleet.update_attribute(:cruiser, 10)
      fleet.update_attribute(:warship, 2)
    }

    context 'when planet is found and belongs to another user' do
      it 'sets enemy_planet and planet_exist to true' do
        post :add_fleet, params: { index: 9, planet_id: enemy_planet.id }
        expect(assigns(:select_options).to_s).to include('attack')
        expect(assigns(:select_options).to_s).not_to include('colonize')
        expect(assigns(:select_options).to_s).not_to include('expedition')

        expect(assigns(:ships).to_s).to include("Cruiser")
        expect(assigns(:ships).to_s).to include("Warship")
        expect(assigns(:ships).to_s).not_to include("Light Fighter")
      end
    end

    context 'when planet belongs to user' do
      it 'sets enemy_planet to false and planet_exist to true' do
        post :add_fleet, params: { index: planet.planet_position - 1, planet_id: planet.id }
        expect(assigns(:select_options).to_s).to include('transport')
        expect(assigns(:select_options).to_s).not_to include('attack')
        expect(assigns(:select_options).to_s).not_to include('colonize')
        expect(assigns(:select_options).to_s).not_to include('expedition')

        expect(assigns(:ships).to_s).to include("Cruiser")
        expect(assigns(:ships).to_s).to include("Warship")
        expect(assigns(:ships).to_s).not_to include("Light Fighter")
      end
    end

    context 'when planet is not found' do
      it 'sets enemy_planet and planet_exist to false' do
        post :add_fleet, params: { index: 13 }
        expect(assigns(:select_options).to_s).to include('colonize')
        expect(assigns(:select_options).to_s).not_to include('attack')
        expect(assigns(:select_options).to_s).not_to include('transport')
        expect(assigns(:select_options).to_s).not_to include('expedition')

        expect(assigns(:ships).to_s).to include("Cruiser")
        expect(assigns(:ships).to_s).to include("Warship")
        expect(assigns(:ships).to_s).not_to include("Light Fighter")
      end
    end

    context 'when coordinate is expedition' do
      it 'sets @select_options correctly for expedition' do
        post :add_fleet, params: { index: 15 }
        expect(assigns(:select_options).to_s).to include('expedition')
        expect(assigns(:select_options).to_s).not_to include('attack')
        expect(assigns(:select_options).to_s).not_to include('transport')
        expect(assigns(:select_options).to_s).not_to include('colonize')

        expect(assigns(:ships).to_s).to include("Cruiser")
        expect(assigns(:ships).to_s).to include("Warship")
        expect(assigns(:ships).to_s).not_to include("Light Fighter")
      end
    end
  end

  describe 'POST method: send_galaxy_fleet' do
    let(:valid_params) do
      {
        index: 5,
        galaxy: 1,
        solar_system: 1,
        planet_position: 6,
        travel_type: 'attack',
        cruiser: 3,
        light_fighter: 5,
        heavy_fighter: 2,
        warship: 1,
        metal_resource: 100,
        crystal_resource: 50,
        deuterium_resource: 25
      }
    end

    before {
      planet.update_attribute(:metal_resource, 1000)
      planet.update_attribute(:crystal_resource, 500)
      planet.update_attribute(:deuterium_resource, 300)

      fleet = planet.planet_fleet
      fleet.update_attribute(:cruiser, 10)
      fleet.update_attribute(:light_fighter, 20)
      fleet.update_attribute(:heavy_fighter, 5)
      fleet.update_attribute(:warship, 3)
    }

    it 'decreases the fleet ships and planet resources after sending a fleet' do
      post :send_galaxy_fleet, params: valid_params

      planet.reload
      fleet = planet.planet_fleet
      fleet.reload

      expect(fleet.cruiser).to eq(7)
      expect(fleet.light_fighter).to eq(15)
      expect(fleet.heavy_fighter).to eq(3)
      expect(fleet.warship).to eq(2)

      expect(planet.metal_resource).to eq(900)
      expect(planet.crystal_resource).to eq(450)
      expect(planet.deuterium_resource).to eq(275)
    end

    it 'creates a new fleet in SendFleetQueue' do
      expect {
        post :send_galaxy_fleet, params: valid_params
      }.to change(SendFleetQueue, :count).by(1)

      fleet_queue = SendFleetQueue.last
      expect(fleet_queue.galaxy).to eq(1)
      expect(fleet_queue.solar_system).to eq(1)
      expect(fleet_queue.planet_position).to eq(6)
      expect(fleet_queue.travel_type).to eq('attack')
      expect(fleet_queue.cruiser).to eq(3)
      expect(fleet_queue.light_fighter).to eq(5)
      expect(fleet_queue.heavy_fighter).to eq(2)
      expect(fleet_queue.warship).to eq(1)
      expect(fleet_queue.metal_resource).to eq(100)
      expect(fleet_queue.crystal_resource).to eq(50)
      expect(fleet_queue.deuterium_resource).to eq(25)
    end
  end
end