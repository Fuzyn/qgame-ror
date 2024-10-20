module UsersHelper
  extend ApplicationHelper

  def user_sum_points
    self.planets.map { |e| e.planet_sum_points}.sum + Technology.technology_sum_points(self)
  end

  def user_fleet_sum_points
    user_sum_equipment_point(Fleet)
  end

  def user_defence_sum_points
    user_sum_equipment_point(Defence)
  end

  def user_buildings_sum_points
    user_sum_development_point(Buildings)
  end

  private

  def user_sum_equipment_point(clas)
    self.planets.map { |e| clas.planet_equipment_sum_points(e)}.sum
  end

  def user_sum_development_point(clas)
    self.planets.map { |e| clas.development_sum_points(e)}.sum
  end
end
