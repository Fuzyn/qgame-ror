# frozen_string_literal: true

class HyperspaceDrive < Technology
  @points = 480
  @degree_growth = 1.04
  @degree_drop = 0.97
  @order = 5
  @key = "hyperspace_drive".freeze
  @name = "Hyperspace Drive".freeze
  @description = "The Hyperspace Drive is a pinnacle of cosmic travel technology, allowing ships to enter and navigate through a dimension outside of normal space-time. This enables faster-than-light travel across vast distances. By creating a temporary rift into hyperspace, ships can traverse galaxies in mere moments, making it essential for intergalactic exploration and military operations.".freeze
  @img = "technology/hyperspace_drive.png".freeze

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
