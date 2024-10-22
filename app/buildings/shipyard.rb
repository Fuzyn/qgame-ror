# frozen_string_literal: true

class Shipyard < Buildings
  @points = 700
  @degree_growth = 1.2
  @degree_drop = 0.99
  @order = 6
  @key = "shipyard".freeze
  @name = "Shipyard".freeze
  @description = "The Shipyard is a huge space shipyard, designed for the rapid construction of combat ships and defense systems. Thanks to the use of modern materials and advanced construction techniques, the shipyard reduces the time needed to create a fleet and weapons. It is a key point of every developed planet, enabling the rapid production of new ships and strengthening defense lines in the event of a threat.".freeze
  @img = "buildings/shipyard.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :degree_growth
    attr_accessor :degree_drop
    attr_accessor :order
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end

  def self.calculated_degree_growth(planet)
    result = super
    result > 0 ? result : 1
  end
end
