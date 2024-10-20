class PreviewController < ApplicationController
  def index
    @planet = current_planet
    @fleet_points = Fleet.planet_equipment_sum_points(current_planet)
    @defence_points = Defence.planet_equipment_sum_points(current_planet)
    @buildings_points = Buildings.development_sum_points(current_planet)
    @planet_points = current_planet.planet_sum_points

    @user_points = current_user.user_sum_points
    @technology_points = Technology.technology_sum_points(current_user)
    @user_fleet_points = current_user.user_fleet_sum_points
    @user_defence_points = current_user.user_defence_sum_points
    @user_buildings_points = current_user.user_buildings_sum_points
  end
end
