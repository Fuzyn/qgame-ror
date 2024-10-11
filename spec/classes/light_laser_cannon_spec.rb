require 'rails_helper'

RSpec.describe "LightLaserCannon", type: :class do
  let(:user) { create(:user) }

  describe "should return correct attack" do
    it 'user_attack' do
      expect(LightLaserCannon.user_attack(user)).to eq(200)
      user.user_technology.increment!('laser_technology', 1)
      expect(LightLaserCannon.user_attack(user)).to eq(208)
    end
  end
end
