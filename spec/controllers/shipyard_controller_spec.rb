require 'rails_helper'

RSpec.describe ShipyardController, type: :controller do
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
      expect(JSON.parse(response.body).size).to eq(4)
      expect(response.body).to include("Light Fighter")
      expect(response.body).to include("Heavy Fighter")
      expect(response.body).to include("Cruiser")
      expect(response.body).to include("Warship")
      expect(JSON.parse(response.body).each_cons(2).all? { |a, b| a["order"] <= b["order"] }).to be true
    end
  end

  describe "POST method: build" do
    context "build" do
      context "successful" do
        it "Heavy Fighter" do
          post :build, params: {key: "heavy_fighter", quantity: 2, name: "Heavy Fighter"}
          expect(flash[:notice]).to eq("Build: 2 Heavy Fighter")

          post :build, params: {key: "heavy_fighter", quantity: 4, name: "Heavy Fighter"}
          expect(flash[:notice]).to eq("Build: 4 Heavy Fighter")
        end

        it "Light Fighter and Cruiser" do
          post :build, params: {key: "light_fighter", quantity: 2, name: "Light Fighter"}
          expect(flash[:notice]).to eq("Build: 2 Light Fighter")

          post :build, params: {key: "cruiser", quantity: 3, name: "Cruiser"}
          expect(flash[:notice]).to eq("Build: 3 Cruiser")
        end
      end

      context "unsuccessful" do
        it "Warship" do
          post :build, params: {key: "warship", quantity: 3, name: "Warship"}
          expect(flash[:notice]).to eq("Build: 3 Warship")

          post :build, params: {key: "warship", quantity: -2, name: "Warship"}
          expect(flash[:alert]).to eq("Error while building Warship")
        end
      end
    end
  end
end