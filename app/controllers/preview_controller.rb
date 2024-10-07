class PreviewController < ApplicationController
  def show
    @user = current_user
    @fleet_points = Fleet.user_equipment_sum_points(current_user)
    @defence_points = Defence.user_equipment_sum_points(current_user)
    @buildings_points = Buildings.user_development_sum_points(current_user)
    @user_points = current_user.user_sum_points
  end
end
