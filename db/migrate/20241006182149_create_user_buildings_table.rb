class CreateUserBuildingsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :user_buildings do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :metal_mine, default: 0
      t.integer :crystal_mine, default: 0
      t.integer :deuterium_refinery, default: 0
      t.integer :power_station, default: 0

      t.timestamps
    end
  end
end
