# frozen_string_literal: true

class ProtectiveTechnology < Technology
  @points = 380
  @degree_growth = 1.03
  @degree_drop = 0.99
  @order = 11
  @key = "protective_technology".freeze
  @name = "Protective Technology".freeze
  @description = "Protective Technology in cosmic tech includes advanced defense systems for shielding spacecraft and space colonies from threats like cosmic radiation, meteor impacts, and enemy attacks. It uses adaptive armor, energy barriers, and AI-powered sensors to detect and neutralize dangers, ensuring safety in space's hostile environment.".freeze
  @img = "technology/protective_technology.png".freeze

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
