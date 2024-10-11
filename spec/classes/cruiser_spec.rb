require 'rails_helper'

RSpec.describe "Cruiser", type: :class do
  let(:user) { create(:user) }

  describe "should return correct speed" do
    it 'user_speed' do
      expect(Cruiser.user_speed(user)).to eq(200)
      user.user_technology.increment!('impulse_drive', 1)
      expect(Cruiser.user_speed(user)).to eq(208)
    end
  end

  describe "should return correct combustion" do
    it 'user_combustion' do
      expect(Cruiser.user_combustion(user)).to eq(40)
      user.user_technology.increment!('impulse_drive', 1)
      expect(Cruiser.user_combustion(user)).to eq(38.8)
    end
  end

  describe "should return correct attack" do
    it 'user_attack' do
      expect(Cruiser.user_attack(user)).to eq(200)
      user.user_technology.increment!('ion_technology', 1)
      expect(Cruiser.user_attack(user)).to eq(208)
    end
  end
end
