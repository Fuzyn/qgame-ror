require 'rails_helper'

RSpec.describe "LightIonCannon", type: :class do
  let(:user) { create(:user) }

  describe "should return correct attack" do
    it 'user_attack' do
      expect(LightIonCannon.user_attack(user)).to eq(1000)
      user.user_technology.increment!('ion_technology', 1)
      expect(LightIonCannon.user_attack(user)).to eq(1040)
    end
  end
end
