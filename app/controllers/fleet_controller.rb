class FleetController < ApplicationController
  include SendFleetHelper

  before_action :set_ships

  def index
    @planet = current_planet
  end

  def add_mission
    @galaxy = params[:galaxy]
    @solar_system = params[:solar_system]
    @planet_position = params[:planet_position]

    @planet = Planet.find_by(galaxy: @galaxy, solar_system: @solar_system, planet_position: @planet_position)
    enemy_planet = @planet.present? && @planet.user_id != current_user.id

    @select_options = select_options(@planet.present?, enemy_planet, params[:planet_position].to_i == 16)
  end

  def send_fleet
    add_fleet_to_queue(params, current_user, current_planet)
    set_ships
  end

  private

  def set_ships
    @ships = planet_ships(current_planet)
  end
end
