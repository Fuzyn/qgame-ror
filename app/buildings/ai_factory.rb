# frozen_string_literal: true

class AiFactory < Buildings
  @points = 700
  @degree_growth = 1.2
  @degree_drop = 0.99
  @order = 5
  @key = "ai_factory".freeze
  @name = "AI factory".freeze
  @description = "Advanced AIFactory on an alien planet, where artificial intelligence manages every aspect of production. The factory uses autonomous systems and optimization algorithms that drastically reduce the construction time of buildings, spacecraft and planetary defense. Thanks to advanced automation technology, AIFactory allows for faster infrastructure development, which gives a strategic advantage in the development of the planet and defense.".freeze
  @img = "buildings/ai_factory.png".freeze

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

  def self.calculated_degree_growth(planet)
    result = super
    result > 0 ? result : 1
  end
end
