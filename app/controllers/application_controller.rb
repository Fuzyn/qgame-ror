require 'digest'

class ApplicationController < ActionController::Base
  helper_method :current_user, :current_planet, :user_secret
  before_action :require_login

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_planet
    @current_planet ||= current_user.planets.find(session[:planet_id]) if session[:planet_id] && current_user
  end

  def user_secret(date)
    generate_hash(date)
  end

  def redirect_if_logged_in
    redirect_to preview_path if current_user
  end

  def create_log(message)
    SendLogWorkerJob.perform_later(message, current_user)
  end

  private

  def generate_hash(date)
    input = "#{date.to_s}#{A9n.hash_secret}"

    Digest::SHA256.hexdigest(input)
  end

  def require_login
    unless current_user
      flash[:alert] = "You must be logged in to access this section"
      redirect_to login_path
    end
  end
end
