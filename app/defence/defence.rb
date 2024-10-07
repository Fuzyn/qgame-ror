# frozen_string_literal: true

class Defence
  extend FleetDefenceHelper

  @relation_name = 'user_defence'.freeze
  @source = 'defence'.freeze

  class << self
    attr_accessor :relation_name
    attr_accessor :source
  end

  def self.basic_values
    self.subclasses('defence').map do |e|
      {
        points: e.basic_points,
        shield: e.basic_shield,
        attack: e.basic_attack,
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img
      }
    end
  end

  def self.user_values(user)
    self.subclasses('defence').map do |e|
      {
        points: e.basic_points,
        shield: e.user_shield,
        attack: e.user_attack,
        key: e.basic_key,
        name: e.basic_name,
        description: e.basic_description,
        img: e.basic_img,
        count: user.user_defence[e.basic_key]
      }
    end
  end
end
