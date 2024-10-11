require 'rails_helper'

RSpec.describe "HeavyFighter", type: :class do
  let(:user) { create(:user) }
  
  describe "should return correct speed" do
    it 'user_speed' do
      expect(HeavyFighter.user_speed(user)).to eq(140)
      user.user_technology.increment!('combustion_drive', 1)
      expect(HeavyFighter.user_speed(user)).to eq(145.6)
    end
  end

  describe "should return correct combustion" do
    it 'user_combustion' do
      expect(HeavyFighter.user_combustion(user)).to eq(20)
      user.user_technology.increment!('combustion_drive', 1)
      expect(HeavyFighter.user_combustion(user)).to eq(19.4)
    end
  end

  describe "should return correct attack" do
    it 'user_attack' do
      expect(HeavyFighter.user_attack(user)).to eq(60)
      user.user_technology.increment!('laser_technology', 1)
      expect(HeavyFighter.user_attack(user)).to eq(62.4)
    end
  end
end
