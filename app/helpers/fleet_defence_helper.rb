# frozen_string_literal: true

module FleetDefenceHelper
  include ApplicationHelper

  def basic_shield
    self.try(:shield)
  end

  def user_shield(user)
    begin
      (self.shield * ProtectiveTechnology.calculated_degree_growth(user)).round(2)
    rescue
      nil
    end
  end

  def basic_attack
    self.try(:attack)
  end

  def user_attack(user)
    begin
      (self.attack * CombatTechnology.calculated_degree_growth(user)).round(2)
    rescue
      nil
    end
  end

  def basic_speed
    self.try(:speed)
  end

  def user_speed(user)
    begin
      (self.speed * DriveTechnology.calculated_degree_growth(user)).round(2)
    rescue
      nil
    end
  end

  def basic_capacity
    self.try(:capacity)
  end

  def user_capacity(user)
    begin
      (self.capacity * StorageTechnology.calculated_degree_growth(user)).round(2)
    rescue
      nil
    end
  end

  def basic_combustion
    self.try(:combustion)
  end

  def user_combustion(user)
    begin
      (self.combustion * DriveTechnology.calculated_degree_drop(user)).round(2)
    rescue
      nil
    end
  end

  def planet_equipment_sum_points(planet)
    self.subclasses(default_source).map { |e| e.basic_points * planet.send(default_relation_name)[e.basic_key] }.sum.to_i
  end
end
