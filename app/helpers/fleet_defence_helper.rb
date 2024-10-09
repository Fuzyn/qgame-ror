# frozen_string_literal: true

module FleetDefenceHelper
  include ApplicationHelper

  def basic_shield
    self.shield
  end

  def user_shield
    self.shield * 2
  end

  def basic_attack
    self.attack
  end

  def user_attack
    self.attack * 2
  end

  def basic_speed
    self.speed
  end

  def user_speed
    self.speed * 2
  end

  def basic_capacity
    self.capacity
  end

  def user_capacity
    self.capacity * 2
  end

  def basic_combustion
    self.combustion
  end

  def user_combustion
    self.combustion * 2
  end

  def planet_equipment_sum_points(planet)
    self.subclasses(default_source).map { |e| e.basic_points * planet.send(default_relation_name)[e.basic_key] }.sum.to_i
  end
end
