class AllianceController < ApplicationController
  def index
    if current_user.alliance_id.present?
      @alliance = Alliance.find(current_user.alliance_id)
      @alliance_users = User.where(alliance_id: current_user.alliance_id)
    end
  end

  def search
    if current_user.alliance_id.present?
      redirect_to alliance_path
    else
      query = ActionController::Base.helpers.sanitize(params[:query])

      if params[:query].present?
        @alliances = Alliance.where('name ILIKE ?', "%#{query}%")
      else
        @alliances = Alliance.none
      end
    end
  end

  def join
    @alliance = Alliance.find(params[:id])

    if @alliance.present?
      current_user.update_attribute(:alliance_id, @alliance.id)

      redirect_to alliance_path, notice: "You have successfully joined the alliance."
    end
  end

  def new
    if current_user.alliance_id.present?
      redirect_to alliance_path
    else
      @alliance = Alliance.new
    end
  end

  def create
    @alliance = Alliance.new(alliance_params)
    if @alliance.save
      current_user.update_attribute(:alliance_id, @alliance.id)
      redirect_to alliance_path, notice: "Alliance created and you have joined the alliance."
    else
      render :new, status: :unprocessable_entity, alert: "Failed to create alliance."
    end
  end

  def leave
    current_user.update_attribute(:alliance_id, nil)
    redirect_to alliance_path, notice: "You have successfully left the alliance."
  end

  private

  def alliance_params
    params.require(:alliance).permit(:name, :short)
  end
end
