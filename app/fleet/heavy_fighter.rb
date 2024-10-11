# frozen_string_literal: true

class HeavyFighter < Fleet
  @points = 3000
  @shield = 25
  @attack = 60
  @speed = 140
  @capacity = 3500
  @combustion = 20
  @order = 2
  @key = "heavy_fighter".freeze
  @name = "Heavy Fighter".freeze
  @description = "The Heavy Fighter is a powerful fighting machine, built for intense combat and battlefield domination. Armed with multi-barreled plasma cannons, long-range missiles and advanced defense systems, it is a formidable opponent for larger ships and groups of fighters. Although slower and less maneuverable than its lighter counterpart, it makes up for it with exceptional durability and firepower, able to withstand even the most ferocious attacks. Perfect for covering allies and breaking the enemy's defense line.".freeze
  @img = "fleet/heavy_fighter.png".freeze

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
    (super * LaserTechnology.calculated_degree_growth(user)).round(2)
  end
end
