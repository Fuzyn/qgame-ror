require 'rails_helper'

RSpec.describe "User management", type: :system do
  let(:user) { create(:user) }

  describe "Registration" do
    it "allows a user to register with valid credentials" do
      visit new_user_path

      fill_in "Email", with: user.email
      fill_in "Password", with: user.password
      fill_in "Password confirmation", with: user.password_confirmation
      click_button "Register"

      expect(page).to have_content("Account created successfully")
      expect(current_path).to eq(login_path)
    end

    it "displays error messages when registration fails" do
      visit new_user_path

      fill_in "Email", with: ""
      fill_in "Password", with: "short"
      fill_in "Password confirmation", with: "different"
      click_button "Register"

      expect(page).to have_content("Email can't be blank")
      expect(page).to have_content("Password is too short (minimum is 6 characters)")
      expect(page).to have_content("Password confirmation doesn't match Password")
      expect(current_path).to eq(new_user_path)
    end
  end

  describe "Logging in" do
    let(:valid_email) { Faker::Internet.email }
    let(:valid_password) { Faker::Internet.password(min_length: 8) }

    before do
      visit new_user_path
      fill_in "Email", with: valid_email
      fill_in "Password", with: valid_password
      fill_in "Password confirmation", with: valid_password
      click_button "Register"

      expect(page).to have_content("Account created successfully")
    end

    it "allows a registered user to log in" do
      visit login_path

      fill_in "Email", with: valid_email
      fill_in "Password", with: valid_password
      click_button "Log In"

      expect(page).to have_content(valid_email)
      expect(current_path).to eq(preview_path)
    end

    it "displays error messages for invalid login" do
      visit login_path

      fill_in "Email", with: valid_email
      fill_in "Password", with: "wrong_password"
      click_button "Log In"

      expect(page).to have_content("Invalid email or password")
      expect(current_path).to eq(login_path)
    end
  end
end