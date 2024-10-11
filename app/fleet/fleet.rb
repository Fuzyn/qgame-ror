# frozen_string_literal: true

class Fleet
  extend FleetDefenceHelper

  @relation_name = 'planet_fleet'.freeze
  @source = 'fleet'.freeze

  class << self
    attr_accessor :relation_name
    attr_accessor :source
  end

  def self.planet_values(planet)
    user = planet.user
    self.subclasses(@source).map do |e|
      {
        points: e.basic_points,
        basic_shield: e.basic_shield,
        basic_attack: e.basic_attack,
        basic_speed: e.basic_speed,
        basic_capacity: e.basic_capacity,
        basic_combustion: e.basic_combustion,
        shield: e.user_shield(user).round(2),
        attack: e.user_attack(user).round(2),
        speed: e.user_speed(user).round(2),
        capacity: e.user_capacity(user).round(2),
        combustion: e.user_combustion(user).round(2),
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img,
        count: planet.planet_fleet[e.basic_key],
        order: e.class_order
      }
    end
  end
end
