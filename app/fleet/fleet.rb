# frozen_string_literal: true

class Fleet
  extend FleetDefenceHelper

  @relation_name = 'user_fleet'.freeze
  @source = 'fleet'.freeze

  class << self
    attr_accessor :relation_name
    attr_accessor :source
  end

  def self.basic_values
    self.subclasses('fleet').map do |e|
      {
        points: e.basic_points,
        shield: e.basic_shield,
        attack: e.basic_attack,
        speed: e.basic_speed,
        capacity: e.basic_capacity,
        combustion: e.basic_combustion,
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img
      }
    end
  end

  def self.user_values(user)
    self.subclasses('fleet').map do |e|
      {
        points: e.basic_points,
        shield: e.user_shield,
        attack: e.user_attack,
        speed: e.user_speed,
        capacity: e.user_capacity,
        combustion: e.user_combustion,
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img,
        count: user.user_fleet[e.basic_key]
      }
    end
  end
end
