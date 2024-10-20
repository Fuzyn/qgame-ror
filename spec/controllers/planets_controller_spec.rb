require 'rails_helper'

RSpec.describe PlanetsController, type: :controller do
  let(:user) { create(:user) }
  let(:planet) { create(:planet, user: user) }

  before do
    session[:user_id] = user.id
    session[:planet_id] = planet.id
  end

  describe 'GET method: planet_name' do
    it 'assigns the planet name to @planet_name' do
      get :planet_name
      expect(assigns(:planet_name)).to eq(planet.name)
    end

    it 'renders the planet_name template' do
      get :planet_name
      expect(response).to render_template(:planet_name)
    end
  end

  describe 'POST method: change_name' do
    let(:new_name) { 'NewPlanetName' }

    it 'sanitizes the input and updates the planet name' do
      post :change_name, params: { planet_name: new_name }
      expect(planet.reload.name).to eq(new_name)
    end

    it 'redirects to the preview path after updating the name' do
      post :change_name, params: { planet_name: new_name }
      expect(response).to redirect_to(preview_path)
    end

    it 'does not update the name with harmful HTML' do
      post :change_name, params: { planet_name: '<script>alert(1)</script>' }
      expect(planet.reload.name).not_to include('<script>')
      expect(planet.reload.name).to eq(planet.name)
    end
  end
end