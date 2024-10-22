# frozen_string_literal: true

class Laboratory < Buildings
  @points = 700
  @degree_growth = 1.2
  @degree_drop = 0.99
  @order = 7
  @key = "laboratory".freeze
  @name = "Laboratory".freeze
  @description = "In the mysterious Laboratory, scientists conduct intensive research that drives the technological progress of the entire civilization. Thanks to modern laboratories, the time needed for technological research is significantly reduced. Breakthrough discoveries and scientific innovations are being implemented at a record pace, allowing the development of modern defense systems, more efficient drives and innovative technological solutions.".freeze
  @img = "buildings/laboratory.png".freeze

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
