class DefenceController < ApplicationController
  def index
    @defence = Defence.basic_values
    @user_defence = Defence.user_values(current_user)
  end

  def build
    key = params[:key]
    name = params[:name]
    quantity = params[:quantity].to_i

    if current_user.user_defence
      current_user.user_defence.increment!(key, quantity)
      create_log("Defence: User #{current_user.email} build #{quantity} #{name}. Current status: #{current_user.user_defence[key]} - #{name}")
      redirect_to defence_index_path, notice: "Build: #{quantity} #{name}"
    else
      create_log("Defence: Failed build #{quantity} #{name} for user #{current_user.email}")
      redirect_to defence_index_path, alert: 'The defence has not been found'
    end
  end
end
