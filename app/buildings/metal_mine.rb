# frozen_string_literal: true

class MetalMine < Buildings
  @points = 400
  @basic_production = 13
  @degree_growth = 1.3
  @energy_consumption = -3
  @key = "metal_mine".freeze
  @name = "Metal Mine".freeze
  @description = "Metal Mine is a massive structure used to extract rare metals that are necessary for the construction of advanced technologies. Equipped with advanced mining machinery, this mine is surrounded by monolithic metallic hills that reflect intense mining activity. The ecosystem near the Metal Mine is adapted to the harsh conditions, and mining robots are constantly working to transform raw materials into valuable resources.".freeze
  @img = "buildings/metal_mine.png".freeze

  class << self
    attr_accessor :points
    attr_accessor :basic_production
    attr_accessor :degree_growth
    attr_accessor :energy_consumption
    attr_accessor :key
    attr_accessor :name
    attr_accessor :description
    attr_accessor :img
  end
end
