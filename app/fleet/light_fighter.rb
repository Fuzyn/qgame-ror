# frozen_string_literal: true

class LightFighter < Fleet
  @points = 1000
  @shield = 10
  @attack = 20
  @speed = 50
  @capacity = 2000
  @combustion = 10
  @order = 1
  @key = "light_fighter".freeze
  @name = "Light Fighter".freeze
  @description = "A light fighter is a fast and agile combat unit, designed for dynamic maneuvers and lightning-fast attacks. Thanks to its lightness and advanced drive technology, it can move at stunning speeds, making it a difficult target for enemy defense systems. Its armament includes precision laser cannons and missiles, ideal for quick strikes and eliminating opponents. Although it has limited durability, its advantage is the ability to immediately withdraw from the battlefield and avoid direct clashes.".freeze
  @img = "fleet/light_fighter.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :shield
    attr_accessor :attack
    attr_accessor :speed
    attr_accessor :capacity
    attr_accessor :combustion
    attr_accessor :order
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end

  def self.user_speed(user)
    (super * CombustionDrive.calculated_degree_growth(user)).round(2)
  end

  def self.user_combustion(user)
    (super * CombustionDrive.calculated_degree_drop(user)).round(2)
  end

  def self.user_attack(user)
    (super * RocketTechnology.calculated_degree_growth(user)).round(2)
  end
end
