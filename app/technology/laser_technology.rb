# frozen_string_literal: true

class LaserTechnology < Technology
  @points = 420
  @degree_growth = 1.04
  @degree_drop = 0.99
  @order = 8
  @key = "laser_technology".freeze
  @name = "Laser Technology".freeze
  @description = "Laser Technology focuses on the development of high-energy beams capable of cutting through ships and defenses with pinpoint precision. These directed-energy weapons are a staple in space combat, offering the advantage of near-instantaneous impact over vast distances. They are highly effective in surgical strikes against enemy fleets and installations.".freeze
  @img = "technology/laser_technology.png".freeze

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
