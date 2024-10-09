class ChangeUserTables < ActiveRecord::Migration[7.0]
  def change
    rename_table :user_buildings, :planet_buildings
    rename_table :user_defences, :planet_defences
    rename_table :user_fleets, :planet_fleets

    add_reference :planet_buildings, :planet, foreign_key: true, index: true
    add_reference :planet_defences, :planet, foreign_key: true, index: true
    add_reference :planet_fleets, :planet, foreign_key: true, index: true
  end
end
