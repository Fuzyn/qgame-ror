# frozen_string_literal: true

class PlasmaTechnology < Technology
  @points = 500
  @degree_growth = 1.04
  @degree_drop = 0.99
  @order = 10
  @key = "plasma_technology".freeze
  @name = "Plasma Technology".freeze
  @description = "Plasma Technology weaponizes superheated matter in the form of plasma, which is held together by magnetic fields. Plasma weapons inflict devastating damage by melting through armor and shields with ease. They are slower than lasers but far more destructive upon impact, making them ideal for large-scale battles or heavily armored targets.".freeze
  @img = "technology/plasma_technology.png".freeze

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
