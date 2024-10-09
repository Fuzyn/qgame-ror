class DefenceController < ApplicationController
  def index
    @planet_defence = Defence.planet_values(current_planet)

    respond_to do |format|
      format.html
      format.json { render json: @planet_defence }
    end
  end

  def build
    key = params[:key]
    name = params[:name]
    quantity = params[:quantity].to_i

    if current_planet.planet_defence && quantity > 0
      current_planet.planet_defence.increment!(key, quantity)
      create_log("Defence: User #{current_user.email} build #{quantity} #{name}. Current status: #{current_planet.planet_defence[key]} - #{name}")
      redirect_to defence_path, notice: "Build: #{quantity} #{name}"
    else
      create_log("Defence: Failed build #{quantity} #{name} for user #{current_user.email}")
      redirect_to defence_path, alert: "Error while building #{name}"
    end
  end
end
