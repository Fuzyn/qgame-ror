# frozen_string_literal: true

class Cruiser < Fleet
  @points = 8000
  @shield = 60
  @attack = 200
  @speed = 200
  @capacity = 8000
  @combustion = 40
  @key = "cruiser".freeze
  @name = "Cruiser".freeze
  @description = "The cruiser is a versatile, medium-sized spacecraft used for both combat and exploration missions. Its design combines agility with solid armor, making it an excellent choice for patrolling distant sectors of space. The cruiser is equipped with advanced propulsion systems allowing for quick movement between stars and modern protective shields that absorb most enemy attacks. Its armament includes long-range lasers, plasma missile launchers and combat drones. Perfect for escort and fast combat operations.".freeze
  @img = "fleet/cruiser.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :shield
    attr_accessor :attack
    attr_accessor :speed
    attr_accessor :capacity
    attr_accessor :combustion
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end
end
