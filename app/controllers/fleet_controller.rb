class FleetController < ApplicationController
  def index
    @fleet = Fleet.basic_values
    @user_fleet = Fleet.user_values(current_user)
  end

  def build
    key = params[:key]
    name = params[:name]
    quantity = params[:quantity].to_i

    if current_user.user_fleet
      current_user.user_fleet.increment!(key, quantity)
      create_log("Fleet: User #{current_user.email} build #{quantity} #{name}. Current status: #{current_user.user_fleet[key]} - #{name}")
      redirect_to fleet_index_path, notice: "Build: #{quantity} #{name}"
    else
      create_log("Fleet: Failed build #{quantity} #{name} for user #{current_user.email}")
      redirect_to fleet_index_path, alert: 'The fleet has not been found'
    end
  end
end
