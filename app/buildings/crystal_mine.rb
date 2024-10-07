# frozen_string_literal: true

class CrystalMine < Buildings
  @basic_extraction = 10
  @degree_growth = 1.2
  @energy_consumption = -4
  @key = "crystal_mine".freeze
  @name = "Crystal Mine".freeze
  @description = "Crystal Mine is a magical land where light reflects off multicolored crystals, creating a unique aura. This mining building, located in a valley among huge rock formations, specializes in obtaining crystals with unique energy properties. Mining is carried out using ancient technology, and each crystal seems to emanate a power that attracts researchers from all over the universe.".freeze
  @img = "buildings/crystal_mine.png".freeze

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
