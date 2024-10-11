require 'rails_helper'

RSpec.describe "LightFighter", type: :class do
  let(:user) { create(:user) }
  
  describe "should return correct speed" do
    it 'user_speed' do
      expect(LightFighter.user_speed(user)).to eq(50)
      user.user_technology.increment!('combustion_drive', 1)
      expect(LightFighter.user_speed(user)).to eq(52)
    end
  end

  describe "should return correct combustion" do
    it 'user_combustion' do
      expect(LightFighter.user_combustion(user)).to eq(10)
      user.user_technology.increment!('combustion_drive', 1)
      expect(LightFighter.user_combustion(user)).to eq(9.7)
    end
  end

  describe "should return correct attack" do
    it 'user_attack' do
      expect(LightFighter.user_attack(user)).to eq(20)
      user.user_technology.increment!('rocket_technology', 1)
      expect(LightFighter.user_attack(user)).to eq(20.8)
    end
  end
end
