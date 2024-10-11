require 'rails_helper'

RSpec.describe "HeavyLaserCannon", type: :class do
  let(:user) { create(:user) }

  describe "should return correct attack" do
    it 'user_attack' do
      expect(HeavyLaserCannon.user_attack(user)).to eq(600)
      user.user_technology.increment!('laser_technology', 1)
      expect(HeavyLaserCannon.user_attack(user)).to eq(624)
    end
  end
end
