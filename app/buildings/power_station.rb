# frozen_string_literal: true

class PowerStation < Buildings
  @points = 500
  @basic_production = 20
  @degree_growth = 1.3
  @energy_consumption = 0
  @order = 4
  @key = "power_station".freeze
  @name = "Power Station".freeze
  @description = "The Deuterium Refinery is a key facility responsible for the processing and refining of deuterium, an extremely valuable isotope of hydrogen. Located outside a rugged landscape, this modern refinery uses advanced cooling and insulation systems to keep chemical processes stable. Its futuristic design is both functional and aesthetic, attracting the attention of scientists who are looking for the possibility of using deuterium in innovative technologies.".freeze
  @img = "buildings/power_station.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :basic_production
    attr_accessor :degree_growth
    attr_accessor :energy_consumption
    attr_accessor :order
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end
end
