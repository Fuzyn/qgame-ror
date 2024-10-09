# frozen_string_literal: true

module FleetDefenceHelper
  include ApplicationHelper

  def basic_shield
    self.try(:shield)
  end

  def user_shield
    begin
      self.shield * 2
    rescue
      nil
    end
  end

  def basic_attack
    self.try(:attack)
  end

  def user_attack
    begin
      self.attack * 2
    rescue
      nil
    end
  end

  def basic_speed
    self.try(:speed)
  end

  def user_speed
    begin
      self.speed * 2
    rescue
      nil
    end
  end

  def basic_capacity
    self.try(:capacity)
  end

  def user_capacity
    begin
      self.capacity * 2
    rescue
      nil
    end
  end

  def basic_combustion
    self.try(:combustion)
  end

  def user_combustion
    begin
      self.combustion * 2
    rescue
      nil
    end
  end

  def planet_equipment_sum_points(planet)
    self.subclasses(default_source).map { |e| e.basic_points * planet.send(default_relation_name)[e.basic_key] }.sum.to_i
  end
end
