# frozen_string_literal: true

module FleetWorkerHelper
  include SendFleetHelper

  def execute_sent_fleet(record)
    Rails.logger.info("Start time: #{Time.now}")
    if record.direction == 'to'
      if record.travel_type == 'transport'
        transport(record)
      elsif record.travel_type == 'attack'
        attack(record)
      elsif record.travel_type == 'spy'
        spy(record)
      elsif record.travel_type == 'expedition'
        expedition(record)
      elsif record.travel_type == 'colonize'
        colonize(record)
      end
    else
      record.update_attribute(:deleted, true)
      return_fleet(record)
    end
  end

  private

  def find_planet(record)
    Planet.find_by(galaxy: record.galaxy, solar_system: record.solar_system, planet_position: record.planet_position)
  end

  def turn_fleet_around(record)
    source_planet = record.planet

    record.galaxy = source_planet.galaxy
    record.solar_system = source_planet.solar_system
    record.planet_position = source_planet.planet_position
    record.direction = 'from'
    record.end_time = Time.now + (record.end_time - record.created_at)
    record.save!

    schedule_fleet_task(record)
  end

  def return_fleet(record)
    fleet = record.planet.planet_fleet
    planet = record.planet

    fleet.cruiser += record.cruiser
    fleet.light_fighter += record.light_fighter
    fleet.heavy_fighter += record.heavy_fighter
    fleet.warship += record.warship
    fleet.save!

    planet.metal_resource += record.metal_resource
    planet.crystal_resource += record.crystal_resource
    planet.deuterium_resource += record.deuterium_resource
    planet.save!
    Rails.logger.info("Start time: #{Time.now}")
  end

  def transport(record)
    target_planet = find_planet(record)

    target_planet.metal_resource += record.metal_resource
    target_planet.crystal_resource += record.crystal_resource
    target_planet.deuterium_resource += record.deuterium_resource
    target_planet.save!

    turn_fleet_around(record)
  end

  def attack(record)
    # ADD user_id for attacked user eq: target_user_id
    turn_fleet_around(record)
  end

  def spy(record)
    turn_fleet_around(record)
  end

  def expedition(record)
    turn_fleet_around(record)
  end

  def colonize(record)
    record.user.planets.create!(
      {
        name: Faker::Lorem.word&.capitalize,
        galaxy: record.galaxy,
        solar_system: record.solar_system,
        planet_position: record.planet_position,
        photo_number: rand(1..1)
      }
    )

    turn_fleet_around(record)
  end
end
