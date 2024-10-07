module UsersHelper
  extend ApplicationHelper

  def user_sum_points
    Fleet.user_equipment_sum_points(self) +
      Defence.user_equipment_sum_points(self) +
      Buildings.user_development_sum_points(self)
  end

  def user_energy_balance
    PowerStation.production(self) +
      MetalMine.energy(self) +
      CrystalMine.energy(self) +
      DeuteriumRefinery.energy(self)
  end
end
