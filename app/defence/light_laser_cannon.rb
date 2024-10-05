# frozen_string_literal: true

class LightLaserCannon < Defence
  @points = 2000
  @shield = 400
  @attack = 200
  @key = "light_laser_cannon".freeze
  @name = "Light Laser Cannon".freeze
  @description = "The Light Laser Cannon is a fast and agile weapon, perfect for defending against fast, maneuvering spacecraft. Thanks to their low production costs and high rate of fire, these guns can fire concentrated energy beams that disrupt enemy defenses in the blink of an eye. These are perfect tools for close-range combat, where precision and reaction speed are crucial.".freeze
  @img = "defence/light_laser_cannon.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :shield
    attr_accessor :attack
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end
end
