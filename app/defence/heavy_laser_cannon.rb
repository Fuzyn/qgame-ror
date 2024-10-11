# frozen_string_literal: true

class HeavyLaserCannon < Defence
  @points = 4000
  @shield = 600
  @attack = 600
  @order = 3
  @key = "heavy_laser_cannon".freeze
  @name = "Heavy Laser Cannon".freeze
  @description = "The Heavy Laser Cannon is a powerful tool, capable of dealing massive damage to spacecraft through concentrated energy. His energy reservoir allows him to fire several powerful shots that can destroy enemy units or shields in one swing. This is an ideal weapon for defending space stations or larger units, where firepower and durability are crucial.".freeze
  @img = "defence/heavy_laser_cannon.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :shield
    attr_accessor :attack
    attr_accessor :order
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end

  def self.user_attack(user)
    (super * LaserTechnology.calculated_degree_growth(user)).round(2)
  end
end
