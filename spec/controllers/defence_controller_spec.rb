require 'rails_helper'

RSpec.describe DefenceController, type: :controller do
  let(:user) { create(:user) }

  before {
    session[:user_id] = user.id
    session[:planet_id] = user.planets.first&.id
  }

  describe "GET method: index" do
    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
    it "renders the json object" do
      get :index, format: :json
      expect(JSON.parse(response.body).size).to eq(5)
      expect(response.body).to include("Rocket Launcher")
      expect(response.body).to include("Light Laser Cannon")
      expect(response.body).to include("Heavy Laser Cannon")
      expect(response.body).to include("Light Ion Cannon")
      expect(response.body).to include("Heavy Ion Cannon")
      expect(JSON.parse(response.body).each_cons(2).all? { |a, b| a["order"] <= b["order"] }).to be true
    end
  end

  describe "POST method: build" do
    context "build" do
      context "successful" do
        it "Heavy Ion Cannon" do
          post :build, params: {key: "heavy_ion_cannon", quantity: 1, name: "Heavy Ion Cannon"}
          expect(user.planets.first&.planet_defence&.heavy_ion_cannon).to eq(1)
          expect(flash[:notice]).to eq("Build: 1 Heavy Ion Cannon")

          post :build, params: {key: "heavy_ion_cannon", quantity: 3, name: "Heavy Ion Cannon"}
          expect(user.planets.first&.planet_defence&.reload&.heavy_ion_cannon).to eq(4)
          expect(flash[:notice]).to eq("Build: 3 Heavy Ion Cannon")
        end

        it "Heavy Laser Cannon and Light Laser Cannon" do
          post :build, params: {key: "heavy_laser_cannon", quantity: 2, name: "Heavy Laser Cannon"}
          expect(user.planets.first&.planet_defence&.heavy_laser_cannon).to eq(2)
          expect(flash[:notice]).to eq("Build: 2 Heavy Laser Cannon")

          post :build, params: {key: "light_laser_cannon", quantity: 5, name: "Light Laser Cannon"}
          expect(user.planets.first&.planet_defence&.reload&.light_laser_cannon).to eq(5)
          expect(flash[:notice]).to eq("Build: 5 Light Laser Cannon")
        end
      end

      context "unsuccessful" do
        it "Heavy Laser Cannon" do
          post :build, params: {key: "heavy_laser_cannon", quantity: 2, name: "Heavy Laser Cannon"}
          expect(user.planets.first&.planet_defence&.heavy_laser_cannon).to eq(2)
          expect(flash[:notice]).to eq("Build: 2 Heavy Laser Cannon")

          post :build, params: {key: "heavy_laser_cannon", quantity: -2, name: "Heavy Laser Cannon"}
          expect(user.planets.first&.planet_defence&.heavy_laser_cannon).to eq(2)
          expect(flash[:alert]).to eq("Error while building Heavy Laser Cannon")
        end
      end
    end
  end
end