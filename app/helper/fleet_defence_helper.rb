# frozen_string_literal: true

module FleetDefenceHelper
  def basic_points
    self.points
  end

  def user_points
    self.points * 2
  end

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

  def basic_key
    self.key
  end

  def basic_name
    self.name
  end

  def basic_description
    self.description
  end

  def basic_img
    self.img
  end
end
