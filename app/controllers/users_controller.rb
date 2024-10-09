class UsersController < ApplicationController
  layout "auth"
  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_log("User created: #{user_params[:email]}")
      redirect_to login_path, notice: "Account created successfully"
    else
      create_log("Error while creating the user: #{user_params[:email]}; Errors: #{@user&.errors&.errors&.map(&:message)&.join(', ')}")
      render :new, status: :unprocessable_entity
    end
  end

  def resources
    render json: {
      metal_resource: current_planet.metal_resource,
      crystal_resource: current_planet.crystal_resource,
      deuterium_resource: current_planet.deuterium_resource
    }
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
