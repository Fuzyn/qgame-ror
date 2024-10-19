class PlanetsController < ApplicationController

  def planet_name
    @planet_name = current_planet.name
  end

  def change_name
    name = ActionController::Base.helpers.sanitize(params[:planet_name])
    current_planet.update_attribute(:name, name)

    redirect_to preview_path
  end
end
