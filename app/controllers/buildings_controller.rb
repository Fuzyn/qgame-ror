class BuildingsController < ApplicationController
  def index
    @planet_buildings = Buildings.planet_values(current_planet)
    @building_queue = current_user.build_queues.building.map(&:queue_values)

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

    if current_user.build_queues.building.length <= 2 && (level < 0 ? building_level > 0 : true) && (level == 1 || level == -1)
      end_time = Time.now + 10.seconds

      PublishQueue::BuildingQueue.new(
        data: {
          end_time: end_time,
          secret_hash: user_secret(end_time.strftime("%Y-%m-%dT%H:%M:%S.%L%:z")),
          user_id: current_user.id,
          user_email: current_user.email,
          key: key,
          source: 'planet_building',
          quantity: level
        }
      ).add_assignment
      sleep(0.5)
      create_log("Building: User #{current_user.email} build #{name}. Current status: #{current_planet.planet_building[key]} - #{name}")
      redirect_to building_path, notice: "Build #{current_planet.planet_building[key] + level} - #{name}"
    else
      create_log("Building: Failed build #{name} for user #{current_user.email}")
      redirect_to building_path, alert: "Error while building #{name}"
    end
  end
end
