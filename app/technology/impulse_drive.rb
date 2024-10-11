# frozen_string_literal: true

class ImpulseDrive < Technology
  @points = 460
  @degree_growth = 1.04
  @degree_drop = 0.97
  @order = 4
  @key = "impulse_drive".freeze
  @name = "Impulse Drive".freeze
  @description = "Impulse Drive represents a major leap from combustion-based propulsion, using ionized particles to create thrust. It allows ships to achieve significant speeds within a star system while maintaining energy efficiency. It's ideal for mid-range travel and is commonly used in combat due to its responsiveness and quick acceleration.".freeze
  @img = "technology/impulse_drive.png".freeze

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
