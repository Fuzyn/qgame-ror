# frozen_string_literal: true

class EnergyTechnology < Technology
  @points = 380
  @degree_growth = 1.03
  @degree_drop = 0.98
  @order = 1
  @key = "energy_technology".freeze
  @name = "Energy Technology".freeze
  @description = "Energy Technology is the cornerstone of all advanced space technologies, enabling the harnessing and efficient utilization of cosmic energy sources. Through this technology, spacecrafts and planetary systems draw power from stars, antimatter, and other celestial sources, allowing them to operate at unparalleled levels of efficiency and sustainability. It's fundamental for powering drives, shields, and high-end weapon systems.".freeze
  @img = "technology/energy_technology.png".freeze

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
