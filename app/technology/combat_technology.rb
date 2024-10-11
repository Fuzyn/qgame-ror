# frozen_string_literal: true

class CombatTechnology < Technology
  @points = 380
  @degree_growth = 1.06
  @degree_drop = 0.99
  @order = 6
  @key = "combat_technology".freeze
  @name = "Combat Technology".freeze
  @description = "Combat Technology encompasses all advancements in the art of war within space. It includes not only weapon systems but also defensive measures, tactics, and intelligence technologies designed to ensure dominance in space combat. From shields to tactical AI, these advancements are crucial for victory in the battlefield.".freeze
  @img = "technology/combat_technology.png".freeze

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
