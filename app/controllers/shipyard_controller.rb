class ShipyardController < ApplicationController
  def index
    @planet_fleet = Fleet.planet_values(current_planet)
    @fleet_queue = current_user.build_queues.fleet.map(&:queue_values)

    respond_to do |format|
      format.html
      format.json { render json: @planet_fleet }
    end
  end

  def build
    key = params[:key]
    name = params[:name]
    quantity = params[:quantity].to_i

    if current_user.build_queues.fleet.length <= 2 && quantity > 0
      end_time = Time.now + 10.seconds

      PublishQueue::FleetQueue.new(
        data: {
          end_time: end_time,
          secret_hash: user_secret(end_time.strftime("%Y-%m-%dT%H:%M:%S.%L%:z")),
          user_id: current_user.id,
          user_email: current_user.email,
          key: key,
          source: 'planet_fleet',
          quantity: quantity
        }
      ).add_assignment
      create_log("Fleet: User #{current_user.email} build #{quantity} #{name}. Current status: #{current_planet.planet_fleet[key]} - #{name}")
      sleep(0.5)
      redirect_to shipyard_path, notice: "Build: #{quantity} #{name}"
    else
      create_log("Fleet: Failed build #{quantity} #{name} for user #{current_user.email}")
      redirect_to shipyard_path, alert: "Error while building #{name}"
    end
  end
end
