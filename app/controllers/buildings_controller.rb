class BuildingsController < ApplicationController
  def index
    @planet_buildings = Buildings.planet_values(current_planet)

    respond_to do |format|
      format.html
      format.json { render json: @planet_buildings }
    end
  end

  def build
    key = params[:key]
    name = params[:name]
    level = params[:level].to_i
    building_level = current_planet.planet_building[key]

    if current_planet.planet_building && (level < 0 ? building_level > 0 : true) && (level == 1 || level == -1)
      current_planet.planet_building.increment!(key, level)
      create_log("Building: User #{current_user.email} build #{name}. Current status: #{current_planet.planet_building[key]} - #{name}")
      redirect_to building_path, notice: "Build #{current_planet.planet_building[key]} - #{name}"
    else
      create_log("Building: Failed build #{name} for user #{current_user.email}")
      redirect_to building_path, alert: "Error while building #{name}"
    end
  end
end
