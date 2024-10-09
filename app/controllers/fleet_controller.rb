class FleetController < ApplicationController
  def index
    @planet_fleet = Fleet.planet_values(current_planet)
  end

  def build
    key = params[:key]
    name = params[:name]
    quantity = params[:quantity].to_i

    if current_planet.planet_fleet
      current_planet.planet_fleet.increment!(key, quantity)
      create_log("Fleet: User #{current_user.email} build #{quantity} #{name}. Current status: #{current_planet.planet_fleet[key]} - #{name}")
      redirect_to fleet_index_path, notice: "Build: #{quantity} #{name}"
    else
      create_log("Fleet: Failed build #{quantity} #{name} for user #{current_user.email}")
      redirect_to fleet_index_path, alert: 'The fleet has not been found'
    end
  end
end
