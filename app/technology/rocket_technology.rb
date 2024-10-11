# frozen_string_literal: true

class RocketTechnology < Technology
  @points = 400
  @degree_growth = 1.04
  @degree_drop = 0.99
  @order = 7
  @key = "rocket_technology".freeze
  @name = "Rocket Technology".freeze
  @description = "Rocket Technology specializes in the development of high-speed, explosive projectiles capable of delivering devastating damage to enemy fleets or planets. This technology has evolved beyond simple chemical rockets to include advanced missile systems that are highly accurate, adaptable, and equipped with nuclear or energy-based warheads.".freeze
  @img = "technology/rocket_technology.png".freeze

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
end
