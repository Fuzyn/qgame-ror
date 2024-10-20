require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { create(:user) }
  let(:unread_message) { create(:user_message, user: user, read_date: nil) }
  let(:read_message) { create(:user_message, user: user, read_date: Time.now) }

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

  describe 'PATCH method: mark_as_read' do
    context 'when the message is unread' do
      it 'marks the message as read' do
        patch :mark_as_read, params: { id: unread_message.id }
        expect(unread_message.reload.read_date).not_to be_nil
      end

      it 'does not change the read_date if the message is already read' do
        previous_read_date = read_message.read_date
        patch :mark_as_read, params: { id: read_message.id }
        expect(read_message.reload.read_date).to eq(previous_read_date)
      end
    end

    context 'when the message belongs to another user' do
      let(:other_user) { create(:user) }
      let(:other_message) { create(:user_message, user: other_user) }

      it 'raises a RecordNotFound error' do
        expect {
          patch :mark_as_read, params: { id: other_message.id }
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end