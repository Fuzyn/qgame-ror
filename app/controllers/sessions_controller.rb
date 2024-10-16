class SessionsController < ApplicationController
  include NotificationHelper

  layout "auth"
  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      create_log(current_user, "User logged in: #{params[:email]}")
      session[:user_id] = user.id
      session[:planet_id] = user.planets.order(:created_at).first&.id
      redirect_to preview_path
    else
      create_log(current_user, "Login attempt failed: #{params[:email]}")
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unauthorized
    end
  end

  def destroy
    create_log(current_user, "User logged out: #{current_user.email}")
    session[:user_id] = nil
    session[:planet_id] = nil
    redirect_to login_path, notice: "Logged out successfully"
  end
end
