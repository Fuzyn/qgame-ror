# frozen_string_literal: true

class CombustionDrive < Technology
  @points = 440
  @degree_growth = 1.04
  @degree_drop = 0.97
  @order = 3
  @key = "combustion_drive".freeze
  @name = "Combustion Drive".freeze
  @description = "A relic from early space exploration, Combustion Drive uses chemical reactions to produce thrust, relying on burning fuel like rocket propellant. Though primitive compared to modern propulsion, it remains useful for smaller vessels and short-range missions due to its simplicity and reliability.".freeze
  @img = "technology/combustion_drive.png".freeze

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
