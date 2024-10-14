class TechnologyController < ApplicationController
  def index
    @user_technology = Technology.user_values(current_user)
    @technology_queue = current_user.build_queues.technology.map(&:queue_values)

    respond_to do |format|
      format.html
      format.json { render json: @user_technology }
    end
  end

  def build
    key = params[:key]
    name = params[:name]
    level = params[:level].to_i

    if current_user.build_queues.technology.length <= 2 && level == 1
      end_time = Time.now + 10.seconds

      PublishQueue::TechnologyQueue.new(
        data: {
          end_time: end_time,
          secret_hash: user_secret(end_time.strftime("%Y-%m-%dT%H:%M:%S.%L%:z")),
          user_id: current_user.id,
          user_email: current_user.email,
          key: key,
          source: 'user_technology',
          quantity: level
        }
      ).add_assignment
      sleep(0.5)
      create_log("Technology: User #{current_user.email} build #{name}. Current status: #{current_user.user_technology[key]} - #{name}")
      redirect_to technology_path, notice: "Build #{current_user.user_technology[key] + level} - #{name}"
    else
      create_log("Technology: Failed build #{name} for user #{current_user.email}")
      redirect_to technology_path, alert: "Error while building #{name}"
    end
  end
end
