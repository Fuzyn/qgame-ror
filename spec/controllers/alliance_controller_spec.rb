require 'rails_helper'

RSpec.describe AllianceController, type: :controller do
  let(:user) { create(:user) }
  let(:alliance) { create(:alliance) }

  before do
    session[:user_id] = user.id
    session[:planet_id] = user.planets.first&.id
  end

  describe 'GET method: index' do
    context 'when user is part of an alliance' do
      before do
        user.update(alliance_id: alliance.id)
        get :index
      end

      it 'assigns @alliance and @alliance_users' do
        expect(assigns(:alliance)).to eq(alliance)
        expect(assigns(:alliance_users)).to include(user)
      end
    end

    context 'when user is not part of an alliance' do
      before { get :index }

      it 'does not assign @alliance or @alliance_users' do
        expect(assigns(:alliance)).to be_nil
        expect(assigns(:alliance_users)).to be_nil
      end
    end
  end

  describe 'GET method: search' do
    context 'when user is already in an alliance' do
      before do
        user.update(alliance_id: alliance.id)
        get :search, params: { query: "test" }
      end

      it 'redirects to alliance path' do
        expect(response).to redirect_to(alliance_path)
      end
    end

    context 'when user is not in an alliance' do
      context 'with a query' do
        it 'assigns matching alliances' do
          matching_alliance = create(:alliance, name: 'Test Alliance')
          get :search, params: { query: 'Test' }

          expect(assigns(:alliances)).to include(matching_alliance)
        end
      end

      context 'without a query' do
        it 'assigns no alliances' do
          get :search, params: { query: '' }
          expect(assigns(:alliances)).to be_empty
        end
      end
    end
  end

  describe 'POST method: join' do
    context 'when the alliance exists' do
      it 'updates the user alliance and redirects with a notice' do
        post :join, params: { id: alliance.id }
        user.reload

        expect(user.alliance_id).to eq(alliance.id)
        expect(response).to redirect_to(alliance_path)
        expect(flash[:notice]).to eq("You have successfully joined the alliance.")
      end
    end
  end

  describe 'GET method: new' do
    context 'when user is already in an alliance' do
      before do
        user.update(alliance_id: alliance.id)
        get :new
      end

      it 'redirects to the alliance path' do
        expect(response).to redirect_to(alliance_path)
      end
    end

    context 'when user is not in an alliance' do
      it 'assigns a new alliance' do
        get :new
        expect(assigns(:alliance)).to be_a_new(Alliance)
      end
    end
  end

  describe 'POST method: create' do
    context 'with valid parameters' do
      let(:alliance_params) { { name: 'New Alliance', short: 'NA' } }

      it 'creates a new alliance and assigns the user to it' do
        expect {
          post :create, params: { alliance: alliance_params }
        }.to change(Alliance, :count).by(1)

        user.reload
        expect(user.alliance_id).to eq(Alliance.last.id)
        expect(response).to redirect_to(alliance_path)
        expect(flash[:notice]).to eq("Alliance created and you have joined the alliance.")
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { name: nil, short: 'NA' } }

      it 'does not create a new alliance and renders the new template' do
        expect {
          post :create, params: { alliance: invalid_params }
        }.to_not change(Alliance, :count)

        expect(response).to render_template(:new)
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'POST method: leave' do
    before do
      user.update(alliance_id: alliance.id)
    end

    it 'removes the user from the alliance and redirects with a notice' do
      post :leave
      user.reload

      expect(user.alliance_id).to be_nil
      expect(response).to redirect_to(alliance_path)
      expect(flash[:notice]).to eq("You have successfully left the alliance.")
    end
  end
end