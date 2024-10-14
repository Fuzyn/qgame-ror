require 'rails_helper'

RSpec.describe TechnologyController, type: :controller do
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
      expect(JSON.parse(response.body).size).to eq(12)
      expect(response.body).to include("Combat Technology")
      expect(response.body).to include("Combustion Drive")
      expect(response.body).to include("Drive Technology")
      expect(response.body).to include("Energy Technology")
      expect(response.body).to include("Hyperspace Drive")
      expect(response.body).to include("Impulse Drive")
      expect(response.body).to include("Ion Technology")
      expect(response.body).to include("Laser Technology")
      expect(response.body).to include("Plasma Technology")
      expect(response.body).to include("Protective Technology")
      expect(response.body).to include("Rocket Technology")
      expect(response.body).to include("Storage Technology")
      expect(JSON.parse(response.body).each_cons(2).all? { |a, b| a["order"] <= b["order"] }).to be true
    end
  end

  describe "POST method: build" do
    context "build" do
      context "successful" do
        it "Combat Technology building" do
          post :build, params: {key: "combat_technology", level: 1, name: "Combat Technology"}
          expect(flash[:notice]).to eq("Build 1 - Combat Technology")
        end

        it "Combat Technology and Combustion Drive building" do
          post :build, params: {key: "combat_technology", level: 1, name: "Combat Technology"}
          expect(flash[:notice]).to eq("Build 1 - Combat Technology")

          post :build, params: {key: "combustion_drive", level: 1, name: "Combustion Drive"}
          expect(flash[:notice]).to eq("Build 1 - Combustion Drive")
        end
      end

      context "unsuccessful" do
        it "Combat Technology building" do
          post :build, params: {key: "combat_technology", level: 2, name: "Combat Technology"}
          expect(flash[:alert]).to eq("Error while building Combat Technology")
        end
      end
    end

    context "destroy should not by possible" do
      it "unsuccessfully Impulse Drive building" do
        post :build, params: {key: "impulse_drive", level: -1, name: "Impulse Drive"}
        expect(flash[:alert]).to eq("Error while building Impulse Drive")
      end
    end
  end
end