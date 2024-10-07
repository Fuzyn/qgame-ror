# frozen_string_literal: true

class DeuteriumRefinery < Buildings
  @basic_extraction = 7
  @degree_growth = 1.2
  @energy_consumption = -5
  @key = "deuterium_refinery".freeze
  @name = "Deuterium Refinery".freeze
  @description = "The Deuterium Refinery is a key facility responsible for the processing and refining of deuterium, an extremely valuable isotope of hydrogen. Located outside a rugged landscape, this modern refinery uses advanced cooling and insulation systems to keep chemical processes stable. Its futuristic design is both functional and aesthetic, attracting the attention of scientists who are looking for the possibility of using deuterium in innovative technologies.".freeze
  @img = "buildings/deuterium_refinery.png".freeze

  class << self
    attr_accessor :basic_extraction
    attr_accessor :degree_growth
    attr_accessor :energy_consumption
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end
end
