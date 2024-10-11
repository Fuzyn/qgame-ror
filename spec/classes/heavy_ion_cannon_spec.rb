require 'rails_helper'

RSpec.describe "HeavyIonCannon", type: :class do
  let(:user) { create(:user) }

  describe "should return correct attack" do
    it 'user_attack' do
      expect(HeavyIonCannon.user_attack(user)).to eq(2000)
      user.user_technology.increment!('ion_technology', 1)
      expect(HeavyIonCannon.user_attack(user)).to eq(2080)
    end
  end
end
