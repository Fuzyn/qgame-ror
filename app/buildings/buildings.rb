# frozen_string_literal: true

class Buildings
  extend DevelopmentHelper

  @relation_name = 'planet_building'.freeze
  @source = 'buildings'.freeze

  class << self
    attr_accessor :relation_name
    attr_accessor :source
  end

  def self.planet_values(planet)
    self.subclasses(@source).map do |e|
      {
        points: e.basic_points,
        production: e.production(planet),
        energy_consumption: e.energy(planet),
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img,
        level: planet.planet_building[e.basic_key],
        order: e.class_order
      }
    end
  end

  def self.production(planet)
    begin
      (self.basic_production + (self.basic_production * self.calculated_degree(planet))).to_i
    rescue
      nil
    end
  end

  def self.energy(planet)
    begin
      (self.energy_consumption * self.calculated_degree(planet)).to_i
    rescue
      nil
    end
  end
end
