class UsersController < ApplicationController
  include NotificationHelper

  layout "auth"
  skip_before_action :require_login, only: [:new, :create]
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      create_log(current_user, "User created: #{user_params[:email]}")
      redirect_to login_path, notice: "Account created successfully"
    else
      create_log(current_user, "Error while creating the user: #{user_params[:email]}; Errors: #{@user&.errors&.errors&.map(&:message)&.join(', ')}")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
