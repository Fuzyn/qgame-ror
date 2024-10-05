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
      redirect_to defence_index_path, notice: "Build: #{quantity} #{name}"
    else
      redirect_to defence_index_path, alert: 'The defence has not been found'
    end
  end
end
