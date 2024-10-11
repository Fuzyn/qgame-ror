# frozen_string_literal: true

class Warship < Fleet
  @points = 12000
  @shield = 100
  @attack = 300
  @speed = 230
  @capacity = 6000
  @combustion = 45
  @order = 4
  @key = "warship".freeze
  @name = "Warship".freeze
  @description = "A warship is a powerful unit designed to conduct military operations on an interstellar scale. Built from the most durable materials, this combat colossus is capable of taking on the largest space fleets. Its deck houses advanced weapons systems: pulsar cannons, antimatter torpedoes and energy launchers capable of destroying entire formations of enemy ships. The warship also has numerous units of marines capable of conducting boarding operations. It is a key element of any fleet, ideal for fighting in direct clashes and long planetary sieges.".freeze
  @img = "fleet/warship.png".freeze

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
    (super * HyperspaceDrive.calculated_degree_growth(user)).round(2)
  end

  def self.user_combustion(user)
    (super * HyperspaceDrive.calculated_degree_drop(user)).round(2)
  end

  def self.user_attack(user)
    (super * PlasmaTechnology.calculated_degree_growth(user)).round(2)
  end
end
