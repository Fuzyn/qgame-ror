require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  let(:user) { create(:user) }
  let(:planet) { create(:planet, user: user) }

  describe 'GET method: change_planet' do
    before do
      allow(controller).to receive(:current_user).and_return(user)
    end

    it 'sets the session planet_id and renders json' do
      get :change_planet, params: { id: planet.id }, format: :json
      expect(session[:planet_id]).to eq(planet.id.to_s)
      expect(response.body).to eq("{}")
    end
  end

  describe 'Method: current_user' do
    it 'returns the current user if session exists' do
      session[:user_id] = user.id
      expect(controller.current_user).to eq(user)
    end

    it 'returns nil if there is no user session' do
      session[:user_id] = nil
      expect(controller.current_user).to be_nil
    end
  end

  describe 'Method: current_planet' do
    before do
      session[:user_id] = user.id
    end

    it 'returns the current planet if session exists' do
      session[:planet_id] = planet.id
      expect(controller.current_planet).to eq(planet)
    end

    it 'returns nil if there is no planet session' do
      session[:planet_id] = nil
      expect(controller.current_planet).to be_nil
    end
  end
end