class AddBuildingsToPlanetBuildings < ActiveRecord::Migration[7.0]
  def change
    add_column :planet_buildings, :ai_factory, :integer, default: 0
    add_column :planet_buildings, :shipyard, :integer, default: 0
    add_column :planet_buildings, :laboratory, :integer, default: 0
  end
end
