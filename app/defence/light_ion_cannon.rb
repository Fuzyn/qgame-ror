# frozen_string_literal: true

class LightIonCannon < Defence
  @points = 5000
  @shield = 800
  @attack = 1000
  @order = 4
  @key = "light_ion_cannon".freeze
  @name = "Light Ion Cannon".freeze
  @description = "The Light Ion Cannon is a modern weapon system that uses ion energy to disrupt enemy electronic systems. Thanks to its design, it is extremely mobile and able to quickly respond to threats. Shots from this cannon can not only damage the ship's structures, but also weaken its defensive capabilities, making it an ideal tool for shielding the fleet from external attacks.".freeze
  @img = "defence/light_ion_cannon.png".freeze

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
end
