require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:valid_attributes) do
    {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'password'
    }
  end

  let(:invalid_attributes) do
    {
      email: 'test@example.com',
      password: 'password',
      password_confirmation: 'different_password'
    }
  end

  describe "GET method: new" do
    context "when user is not logged in" do
      it "returns a success response" do
        get :new
        expect(response).to have_http_status(:success)
        expect(assigns(:user)).to be_a_new(User)
      end
    end

    context "when user is logged in" do
      before { session[:user_id] = create(:user).id }

      it "redirects to the preview path" do
        get :new
        expect(response).to redirect_to(preview_path)
      end
    end
  end

  describe "POST method: create" do
    context "with valid parameters" do
      it "creates a new User" do
        expect {
          post :create, params: { user: valid_attributes }
        }.to change(User, :count).by(1)
      end

      it "redirects to the login path with a notice" do
        post :create, params: { user: valid_attributes }
        expect(response).to redirect_to(login_path)
        expect(flash[:notice]).to eq("Account created successfully")
      end
    end

    context "with invalid parameters" do
      it "does not create a new User" do
        expect {
          post :create, params: { user: invalid_attributes }
        }.not_to change(User, :count)
      end

      it "renders the new template with unprocessable_entity status" do
        post :create, params: { user: invalid_attributes }
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end