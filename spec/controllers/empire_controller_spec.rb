require 'rails_helper'

RSpec.describe EmpireController, type: :controller do
  let(:user) { create(:user) }

  before {
    session[:user_id] = user.id
    session[:planet_id] = user.planets.first&.id
  }

  describe 'GET method: index' do
    it 'assigns the current user to @user' do
      get :index
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end
end