class BuildingsController < ApplicationController
  def index
    @planet_buildings = Buildings.planet_values(current_planet)
  end

  def build
    key = params[:key]
    name = params[:name]
    level = params[:level].to_i
    building_level = current_planet.planet_building[key]

    if current_planet.planet_building && (level < 0 ? building_level > 0 : true)
      current_planet.planet_building.increment!(key, level)
      create_log("Building: User #{current_user.email} build #{name}. Current status: #{current_planet.planet_building[key]} - #{name}")
      redirect_to building_build_path, notice: "Build #{current_planet.planet_building[key]} - #{name}"
    else
      create_log("Building: Failed build #{name} for user #{current_user.email}")
      redirect_to building_build_path, alert: "Error while building #{name}"
    end
  end
end
