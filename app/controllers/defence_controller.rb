class DefenceController < ApplicationController
  include NotificationHelper

  def index
    @planet_defence = Defence.planet_values(current_planet)
    @defence_queue = current_user.build_queues.defence.map(&:queue_values)

    respond_to do |format|
      format.html
      format.json { render json: @planet_defence }
    end
  end

  def build
    key = params[:key]
    name = params[:name]
    quantity = params[:quantity].to_i

    if current_user.build_queues.defence.length <= 2 && quantity > 0
      end_time = Time.now + 10.seconds

      PublishQueue::DefenceQueue.new(
        data: {
          end_time: end_time,
          secret_hash: user_secret(end_time.strftime("%Y-%m-%dT%H:%M:%S.%L%:z")),
          user_id: current_user.id,
          user_email: current_user.email,
          key: key,
          source: 'planet_defence',
          quantity: quantity
        }
      ).add_assignment
      sleep(0.5)
      create_log(current_user, "Defence: User #{current_user.email} build #{quantity} #{name}. Current status: #{current_planet.planet_defence[key]} - #{name}")
      redirect_to defence_path, notice: "Build: #{quantity} #{name}"
    else
      create_log(current_user, "Defence: Failed build #{quantity} #{name} for user #{current_user.email}")
      redirect_to defence_path, alert: "Error while building #{name}"
    end
  end
end
