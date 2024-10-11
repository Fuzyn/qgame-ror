require 'rails_helper'

RSpec.describe "Warship", type: :class do
  let(:user) { create(:user) }
  
  describe "should return correct speed" do
    it 'user_speed' do
      expect(Warship.user_speed(user)).to eq(230)
      user.user_technology.increment!('hyperspace_drive', 1)
      expect(Warship.user_speed(user)).to eq(239.2)
    end
  end

  describe "should return correct combustion" do
    it 'user_combustion' do
      expect(Warship.user_combustion(user)).to eq(45)
      user.user_technology.increment!('hyperspace_drive', 1)
      expect(Warship.user_combustion(user)).to eq(43.65)
    end
  end

  describe "should return correct attack" do
    it 'user_attack' do
      expect(Warship.user_attack(user)).to eq(300)
      user.user_technology.increment!('plasma_technology', 1)
      expect(Warship.user_attack(user)).to eq(312)
    end
  end
end
