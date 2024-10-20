require 'rails_helper'

RSpec.describe PreviewController, type: :controller do
  let(:user) { create(:user) }
  let(:planet) { user.planets.first }
  let(:planet_2) { create(:planet, user: user) }

  before {
    session[:user_id] = user.id
    session[:planet_id] = planet.id
  }

  describe "GET method: index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "renders the json object" do
      planet.planet_fleet.increment!('light_fighter', 1)
      planet.planet_defence.increment!('heavy_ion_cannon', 1)
      planet.planet_building.increment!('metal_mine', 1)
      user.user_technology.increment!('combat_technology', 1)

      planet_2.planet_fleet.increment!('heavy_fighter', 1)
      planet_2.planet_defence.increment!('rocket_launcher', 1)
      planet_2.planet_building.increment!('crystal_mine', 1)

      get :index
      expect(assigns(:planet)).to eq(planet)
      expect(assigns(:fleet_points)).to eq(1000)
      expect(assigns(:defence_points)).to eq(10000)
      expect(assigns(:buildings_points)).to eq(520)
      expect(assigns(:planet_points)).to eq(11520)

      expect(assigns(:user_points)).to eq(16522)
      expect(assigns(:technology_points)).to eq(402)
      expect(assigns(:user_fleet_points)).to eq(4000)
      expect(assigns(:user_defence_points)).to eq(11000)
      expect(assigns(:user_buildings_points)).to eq(1120)
    end
  end
end
