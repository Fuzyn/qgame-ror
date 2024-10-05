require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:user) { create(:user) }

  describe "GET method: new" do
    context "when user is not logged in" do
      it "renders the new template" do
        get :new
        expect(response).to render_template(:new)
      end
    end

    context "when user is logged in" do
      before { session[:user_id] = user.id }

      it "redirects to the preview path" do
        get :new
        expect(response).to redirect_to(preview_path)
      end
    end
  end

  describe "POST method: create" do
    context "with valid credentials" do
      it "logs the user in and redirects to the preview path" do
        post :create, params: { email: user.email, password: user.password }
        expect(session[:user_id]).to eq(user.id)
        expect(response).to redirect_to(preview_path)
      end
    end

    context "with invalid credentials" do
      it "renders the new template with an alert" do
        post :create, params: { email: user.email, password: 'wrong_password' }
        expect(session[:user_id]).to be_nil
        expect(response).to render_template(:new)
        expect(flash.now[:alert]).to eq("Invalid email or password")
      end
    end
  end

  describe "DELETE method: destroy" do
    before { session[:user_id] = user.id }

    it "logs the user out and redirects to the login path" do
      delete :destroy
      expect(session[:user_id]).to be_nil
      expect(response).to redirect_to(login_path)
      expect(flash[:notice]).to eq("Logged out successfully")
    end
  end
end