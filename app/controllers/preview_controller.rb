class PreviewController < ApplicationController
  def index
    @user = current_user
    @planet = current_planet
    @fleet_points = Fleet.planet_equipment_sum_points(current_planet)
    @defence_points = Defence.planet_equipment_sum_points(current_planet)
    @buildings_points = Buildings.planet_development_sum_points(current_planet)
    @planet_points = current_planet.planet_sum_points
    @user_points = current_user.user_sum_points
  end
end
