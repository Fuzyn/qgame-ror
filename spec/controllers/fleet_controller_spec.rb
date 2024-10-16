require 'rails_helper'

RSpec.describe FleetController, type: :controller do
  let(:user) { create(:user) }
  let(:planet) { user.planets.first }
  let(:another_planet) { create(:planet, user: create(:user), galaxy: 1, solar_system: 1, planet_position: 2) }

  before {
    session[:user_id] = user.id
    session[:planet_id] = planet.id
  }

  describe 'GET method: index' do
    it 'assigns the current planet to @planet' do
      get :index
      expect(assigns(:planet)).to eq(planet)
    end

    it 'assign Light Fighter to @ships' do
      planet.planet_fleet.increment!("light_fighter", 1)

      get :index
      expect(assigns(:ships).first[:count]).to eq(1)
      expect(assigns(:ships).first[:name]).to eq("Light Fighter")
    end
  end

  describe 'POST method: add_mission' do
    context 'when planet is found and belongs to another user' do
      it 'assigns @planet and sets enemy_planet to true' do
        post :add_mission, params: { galaxy: another_planet.galaxy, solar_system: another_planet.solar_system, planet_position: another_planet.planet_position }
        expect(assigns(:planet)).to eq(another_planet)
        expect(assigns(:select_options).to_s).to include('attack')
        expect(assigns(:select_options).to_s).not_to include('colonize')
        expect(assigns(:select_options).to_s).not_to include('expedition')
      end
      end

    context 'when planet belongs to user' do
      it 'assigns @planet and sets enemy_planet to true' do
        post :add_mission, params: { galaxy: planet.galaxy, solar_system: planet.solar_system, planet_position: planet.planet_position }
        expect(assigns(:planet)).to eq(planet)
        expect(assigns(:select_options).to_s).to include('transport')
        expect(assigns(:select_options).to_s).not_to include('attack')
        expect(assigns(:select_options).to_s).not_to include('colonize')
        expect(assigns(:select_options).to_s).not_to include('expedition')
      end
    end

    context 'when planet is not found' do
      it 'sets @select_options correctly for space' do
        post :add_mission, params: { galaxy: 1, solar_system: 1, planet_position: 15 }
        expect(assigns(:planet)).to be_nil
        expect(assigns(:select_options).to_s).to include('colonize')
        expect(assigns(:select_options).to_s).not_to include('attack')
        expect(assigns(:select_options).to_s).not_to include('transport')
        expect(assigns(:select_options).to_s).not_to include('expedition')
      end
    end

    context 'when coordinate is expedition' do
      it 'sets @select_options correctly for space' do
        post :add_mission, params: { galaxy: 1, solar_system: 1, planet_position: 16 }
        expect(assigns(:planet)).to be_nil
        expect(assigns(:select_options).to_s).to include('expedition')
        expect(assigns(:select_options).to_s).not_to include('attack')
        expect(assigns(:select_options).to_s).not_to include('transport')
        expect(assigns(:select_options).to_s).not_to include('colonize')
      end
    end
  end

  describe 'POST method: send_fleet' do
    let(:valid_params) do
      {
        galaxy: another_planet.galaxy,
        solar_system: another_planet.solar_system,
        planet_position: another_planet.planet_position,
        travel_type: 'attack',
        cruiser: 5,
        light_fighter: 10,
        heavy_fighter: 2,
        warship: 1,
        metal_resource: 300,
        crystal_resource: 200,
        deuterium_resource: 100
      }
    end

    before {
      planet.update_attribute(:metal_resource, 1000)
      planet.update_attribute(:crystal_resource, 1000)
      planet.update_attribute(:deuterium_resource, 1000)

      fleet = planet.planet_fleet
      fleet.update_attribute(:cruiser, 10)
      fleet.update_attribute(:light_fighter, 20)
      fleet.update_attribute(:heavy_fighter, 5)
      fleet.update_attribute(:warship, 2)
    }

    it 'creates a new SendFleetQueue record' do
      expect {
        post :send_fleet, params: valid_params
      }.to change(SendFleetQueue, :count).by(1)
    end

    it 'deducts the fleet resources from the planet fleet' do
      post :send_fleet, params: valid_params
      fleet = planet.planet_fleet
      fleet.reload

      expect(fleet.cruiser).to eq(5)
      expect(fleet.light_fighter).to eq(10)
      expect(fleet.heavy_fighter).to eq(3)
      expect(fleet.warship).to eq(1)
    end

    it 'deducts the planet resources' do
      post :send_fleet, params: valid_params
      planet.reload

      expect(planet.metal_resource).to eq(700)
      expect(planet.crystal_resource).to eq(800)
      expect(planet.deuterium_resource).to eq(900)
    end
  end
end