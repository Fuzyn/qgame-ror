# frozen_string_literal: true

class Defence
  extend FleetDefenceHelper

  @relation_name = 'planet_defence'.freeze
  @source = 'defence'.freeze

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
        shield: e.user_shield(user).round(2),
        attack: e.user_attack(user).round(2),
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img,
        count: planet.planet_defence[e.basic_key],
        order: e.class_order
      }
    end
  end
end
