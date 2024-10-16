module SendFleetHelper
  include ApplicationHelper

  def select_options(is_planet_exist, is_enemy_planet, is_expedition)
    result = []
    transport = { value: 'transport', label: 'Transport' }

    if is_planet_exist
      if is_enemy_planet
        result << { value: 'attack', label: 'Attack' }
        result << { value: 'spy', label: 'Spy' }
        result << transport
      else
        result << transport
      end
    else
      if is_expedition
        result << { value: 'expedition', label: 'Expedition' }
      else
        result << { value: 'colonize', label: 'Colonize' }
      end
    end

    result
  end

  def planet_ships(planet)
    result = []
    planet_fleet = planet.planet_fleet.attributes.except("id", "user_id", "created_at", "updated_at", "planet_id")

    planet_fleet.each do |key, value|
      if value > 0
        @class = nil

        Dir[Rails.root.join("app/fleet/*.rb")].each do |file|
          require_dependency file
        end

        ObjectSpace.each_object(Class) do |klass|
          if klass.instance_variable_defined?(:@key) && klass.instance_variable_get(:@key) == key
            @class = klass
          end
        end

        result << {
          count: value,
          name: @class&.basic_name,
          key: @class&.basic_key,
          img: @class&.basic_img,
        }
      end
    end
    result
  end

  def add_fleet_to_queue(params, user, planet)
    galaxy = params[:galaxy]
    solar_system = params[:solar_system]
    planet_position = params[:planet_position]

    travel_type = params[:travel_type]

    cruiser = params[:cruiser]&.to_i || 0
    light_fighter = params[:light_fighter]&.to_i || 0
    heavy_fighter = params[:heavy_fighter]&.to_i || 0
    warship = params[:warship]&.to_i || 0

    metal_resource = params[:metal_resource]&.to_i || 0
    crystal_resource = params[:crystal_resource]&.to_i || 0
    deuterium_resource = params[:deuterium_resource]&.to_i || 0

    end_time = Time.now + 10.seconds

    if galaxy.present? && solar_system.present? &&
      planet_position.present? && travel_type.present? && cruiser.present? &&
      light_fighter.present? && heavy_fighter.present? && warship.present? &&
      metal_resource.present? && crystal_resource.present? && deuterium_resource.present?

      new_fleet = SendFleetQueue.create!(
        {
          end_time: end_time,
          secret_hash: user_secret(end_time.strftime("%Y-%m-%dT%H:%M:%S.%L%:z")),
          user: user,
          planet: planet,
          user_email: user.email,
          galaxy: galaxy,
          solar_system: solar_system,
          planet_position: planet_position,
          travel_type: travel_type,
          cruiser: cruiser,
          light_fighter: light_fighter,
          heavy_fighter: heavy_fighter,
          warship: warship,
          metal_resource: metal_resource,
          crystal_resource: crystal_resource,
          deuterium_resource: deuterium_resource,
          direction: 'to'
        }
      )
      schedule_fleet_task(new_fleet)

      fleet = planet.planet_fleet
      planet = planet

      fleet.cruiser -= cruiser
      fleet.light_fighter -= light_fighter
      fleet.heavy_fighter -= heavy_fighter
      fleet.warship -= warship
      fleet.save!

      planet.metal_resource -= metal_resource
      planet.crystal_resource -= crystal_resource
      planet.deuterium_resource -= deuterium_resource
      planet.save!
    end
  end
end
