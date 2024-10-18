class TraderController < ApplicationController
  RESOURCE_VALUES = {
    'metal' => 1,
    'crystal' => 2,
    'deuterium' => 4
  }

  def index
    @planet = current_planet
  end

  def exchange
    @planet = current_planet
    from_resource = params[:from_resource]
    to_resource = params[:to_resource]
    amount = params[:amount].to_i

    from_value = RESOURCE_VALUES[from_resource]
    to_value = RESOURCE_VALUES[to_resource]

    exchange_amount = (amount * from_value / to_value).floor

    if @planet[from_resource + "_resource"] >= amount
      @planet.update("#{from_resource}_resource" => @planet[from_resource + "_resource"] - amount,
                     "#{to_resource}_resource" => @planet[to_resource + "_resource"] + exchange_amount)

      redirect_to trader_path, notice: "Exchange #{amount} #{from_resource.capitalize} to #{exchange_amount} #{to_resource.capitalize}."
    else
      redirect_to trader_path, alert: 'Insufficient resources to exchange.'
    end
  end
end
