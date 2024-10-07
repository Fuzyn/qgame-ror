# frozen_string_literal: true

class Buildings
  extend DevelopmentHelper

  @relation_name = 'user_building'.freeze
  @source = 'buildings'.freeze

  class << self
    attr_accessor :relation_name
    attr_accessor :source
  end

  def self.user_values(user)
    self.subclasses('buildings').map do |e|
      {
        points: e.basic_points,
        production: e.production(user),
        energy_consumption: e.energy(user),
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img,
        level: user.user_building[e.basic_key]
      }
    end
  end

  def self.production(user)
    (self.basic_production + (self.basic_production * self.calculated_degree(user))).to_i
  end

  def self.energy(user)
    (self.energy_consumption * self.calculated_degree(user)).to_i
  end
end
