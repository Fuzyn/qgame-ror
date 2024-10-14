require 'rails_helper'

RSpec.describe BuildingsController, type: :controller do
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
      expect(response.body).to include("Metal Mine")
      expect(response.body).to include("Crystal Mine")
      expect(response.body).to include("Deuterium Refinery")
      expect(response.body).to include("Power Station")
      expect(JSON.parse(response.body).each_cons(2).all? { |a, b| a["order"] <= b["order"] }).to be true
    end
  end

  describe "POST method: build" do
    context "build" do
      context "successful" do
        it "Metal Mine building" do
          post :build, params: {key: "metal_mine", level: 1, name: "Metal Mine"}
          expect(flash[:notice]).to eq("Build 1 - Metal Mine")
        end

        it "Metal Mine and Crystal Mine building" do
          post :build, params: {key: "metal_mine", level: 1, name: "Metal Mine"}
          expect(flash[:notice]).to eq("Build 1 - Metal Mine")

          post :build, params: {key: "crystal_mine", level: 1, name: "Crystal Mine"}
          expect(flash[:notice]).to eq("Build 1 - Crystal Mine")
        end
      end

      context "unsuccessful" do
        it "Metal Mine building" do
          post :build, params: {key: "metal_mine", level: 2, name: "Metal Mine"}
          expect(user.planets.first&.planet_building&.metal_mine).to eq(0)
          expect(flash[:alert]).to eq("Error while building Metal Mine")
        end
      end
    end

    context "destroy" do
      it "successfully Deuterium Refinery building" do
        post :build, params: {key: "deuterium_refinery", level: 1, name: "Deuterium Refinery"}
        expect(flash[:notice]).to eq("Build 1 - Deuterium Refinery")

        post :build, params: {key: "deuterium_refinery", level: -1, name: "Deuterium Refinery"}
        expect(flash[:notice]).to eq("Build 1 - Deuterium Refinery")
      end

      it "unsuccessfully Metal Mine building" do
        post :build, params: {key: "metal_mine", level: -1, name: "Metal Mine"}
        expect(user.planets.first&.planet_building&.metal_mine).to eq(0)
        expect(flash[:alert]).to eq("Error while building Metal Mine")
      end

      it "unsuccessfully Power Station building" do
        post :build, params: {key: "power_station", level: 1, name: "Power Station"}
        expect(flash[:notice]).to eq("Build 1 - Power Station")

        post :build, params: {key: "power_station", level: -2, name: "Power Station"}
        expect(flash[:alert]).to eq("Error while building Power Station")
      end
    end
  end
end