require 'rails_helper'

RSpec.describe "RocketLauncher", type: :class do
  let(:user) { create(:user) }
  
  describe "should return correct attack" do
    it 'user_attack' do
      expect(RocketLauncher.user_attack(user)).to eq(100)
      user.user_technology.increment!('rocket_technology', 1)
      expect(RocketLauncher.user_attack(user)).to eq(104)
    end
  end
end
