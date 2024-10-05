# frozen_string_literal: true

class HeavyIonCannon < Defence
  @points = 10000
  @shield = 1000
  @attack = 2000
  @key = "heavy_ion_cannon".freeze
  @name = "Heavy Ion Cannon".freeze
  @description = "The Heavy Ion Cannon is the most powerful weapon of its type, designed for large-scale defensive missions. Thanks to extremely intense ion shots, it is able to destroy both spaceships and their energy systems. It is ideal for defending against large fleets, where eliminating multiple targets at the same time is crucial. Its advanced targeting systems guarantee high accuracy and effectiveness, and its powerful range makes it one of the most desirable weapons in the space defense arsenal.".freeze
  @img = "defence/heavy_ion_cannon.png".freeze

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
