# frozen_string_literal: true

class Defence
  extend FleetDefenceHelper

  def self.subclasses
    eager_load_fleet_classes
    ObjectSpace.each_object(Class).select { |klass| klass < self }
  end

  def self.eager_load_fleet_classes
    Dir[Rails.root.join('app/defence/*.rb')].each do |file|
      require_dependency file
    end
  end

  def self.basic_values
    self.subclasses.map do |e|
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
    self.subclasses.map do |e|
      {
        points: e.user_points,
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
