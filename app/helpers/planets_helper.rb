module PlanetsHelper
  extend ApplicationHelper

  def planet_sum_points
    Fleet.planet_equipment_sum_points(self) +
      Defence.planet_equipment_sum_points(self) +
      Buildings.planet_development_sum_points(self)
  end

  def planet_energy_balance
    PowerStation.production(self) +
      MetalMine.energy(self) +
      CrystalMine.energy(self) +
      DeuteriumRefinery.energy(self)
  end
end
