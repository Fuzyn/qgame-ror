# frozen_string_literal: true

class Fleet
  extend FleetDefenceHelper

  def self.subclasses
    eager_load_fleet_classes
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.eager_load_fleet_classes
    Dir[Rails.root.join('app/fleet/*.rb')].each do |file|
      require_dependency file
    end
  end

  def self.basic_values
    self.subclasses.map do |e|
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
    self.subclasses.map do |e|
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
