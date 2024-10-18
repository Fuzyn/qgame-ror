class ApplicationController < ActionController::Base
  include ApplicationHelper

  helper_method :current_user, :current_planet, :user_secret
  before_action :require_login

  def change_planet
    session[:planet_id] = params[:id]
    render json: {}
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_planet
    @current_planet ||= current_user.planets.find(session[:planet_id]) if session[:planet_id] && current_user
  end

  def redirect_if_logged_in
    redirect_to preview_path if current_user
  end

  private

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end
end
