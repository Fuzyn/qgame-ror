class TechnologyController < ApplicationController
  def index
    @user_technology = Technology.user_values(current_user)

    respond_to do |format|
      format.html
      format.json { render json: @user_technology }
    end
  end

  def build
    key = params[:key]
    name = params[:name]
    level = params[:level].to_i

    if current_user.user_technology && level == 1
      current_user.user_technology.increment!(key, level)
      create_log("Technology: User #{current_user.email} build #{name}. Current status: #{current_user.user_technology[key]} - #{name}")
      redirect_to technology_path, notice: "Build #{current_user.user_technology[key]} - #{name}"
    else
      create_log("Technology: Failed build #{name} for user #{current_user.email}")
      redirect_to technology_path, alert: "Error while building #{name}"
    end
  end
end
