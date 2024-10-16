class GalaxyController < ApplicationController
  include SendFleetHelper

  before_action :set_coordinate, only: [:index, :add_fleet]

  def index
    planets_in_system = Planet.where(galaxy: @galaxy, solar_system: @solar_system)

    @planets = Array.new(15)
    planets_in_system.each do |planet|
      @planets[planet.planet_position - 1] = planet
    end

    @planets << OpenStruct.new(name: 'Unexplored territories')
  end

  def add_fleet
    @index = params[:index]
    planet_id = params[:planet_id]

    planet_exist = planet_id.present?
    enemy_planet = planet_exist && Planet.find(planet_id).user_id != current_user.id

    @ships = planet_ships(current_planet)
    @select_options = select_options(planet_exist, enemy_planet, @index.to_i == 15)
  end

  def send_galaxy_fleet
    @index = params[:index]
    add_fleet_to_queue(params, current_user, current_planet)
  end

  private

  def set_coordinate
    @galaxy = params[:galaxy] || current_planet.galaxy
    @solar_system = params[:solar_system] || current_planet.solar_system
    @planet_position = params[:index].to_i + 1 || 0
  end
end
