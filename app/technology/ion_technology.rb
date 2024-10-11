# frozen_string_literal: true

class IonTechnology < Technology
  @points = 440
  @degree_growth = 1.04
  @degree_drop = 0.99
  @order = 9
  @key = "ion_technology".freeze
  @name = "Ion Technology".freeze
  @description = "Ion Technology is centered around weaponizing streams of charged particles, disabling or disrupting electronics and systems rather than outright destroying them. Ion cannons and similar devices are capable of neutralizing shields, shutting down engines, and leaving targets vulnerable without necessarily causing physical damage. It's a strategic tool for neutralizing enemy capabilities.".freeze
  @img = "technology/ion_technology.png".freeze

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
