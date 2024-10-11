# frozen_string_literal: true

class DriveTechnology < Technology
  @points = 400
  @degree_growth = 1.06
  @degree_drop = 0.96
  @order = 2
  @key = "drive_technology".freeze
  @name = "Drive Technology".freeze
  @description = "Drive Technology is at the heart of interstellar travel, pushing the boundaries of speed and distance that can be traversed. Advances in this field allow for more efficient propulsion systems that can bend space and time, enabling ships to travel between galaxies in days rather than centuries. Drive Technology encompasses all propulsion systems from basic rocket engines to faster-than-light travel.".freeze
  @img = "technology/drive_technology.png".freeze

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
