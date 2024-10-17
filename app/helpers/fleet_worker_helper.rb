# frozen_string_literal: true

module FleetWorkerHelper
  include SendFleetHelper
  include ApplicationHelper
  include NotificationHelper
  include MessagesHelper

  def execute_sent_fleet(record)
    if record.direction == 'to'
      if record.travel_type == UserMessage::TRANSPORT_KEY
        transport(record)
      elsif record.travel_type == UserMessage::ATTACK_KEY
        attack(record)
      elsif record.travel_type == UserMessage::SPY_KEY
        spy(record)
      elsif record.travel_type == UserMessage::EXPEDITION_KEY
        expedition(record)
      elsif record.travel_type == UserMessage::COLONIZE_KEY
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

  def transport(record)
    create_new_fleet_message(record)
    target_planet = find_planet(record)

    target_planet.metal_resource += record.metal_resource
    target_planet.crystal_resource += record.crystal_resource
    target_planet.deuterium_resource += record.deuterium_resource
    target_planet.save!

    record.metal_resource = 0
    record.crystal_resource = 0
    record.deuterium_resource = 0
    record.save!

    turn_fleet_around(record)
  end

  def attack(record)
    create_new_fleet_message(record)
    # ADD user_id for attacked user eq: target_user_id
    turn_fleet_around(record)
  end

  def spy(record)
    create_new_fleet_message(record)
    turn_fleet_around(record)
  end

  def expedition(record)
    create_new_fleet_message(record)
    turn_fleet_around(record)
  end

  def colonize(record)
    create_new_fleet_message(record)
    record.user.planets.create!(
      {
        name: Faker::Lorem.word&.capitalize,
        galaxy: record.galaxy,
        solar_system: record.solar_system,
        planet_position: record.planet_position,
        photo_number: rand(1..1),
        metal_resource: record.metal_resource,
        crystal_resource: record.crystal_resource,
        deuterium_resource: record.deuterium_resource
      }
    )

    turn_fleet_around(record)
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

    create_new_fleet_message(record)
  end
end
