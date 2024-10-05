class CreateUserDefencesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :user_defences do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :rocket_launcher, default: 0
      t.integer :light_laser_cannon, default: 0
      t.integer :heavy_laser_cannon, default: 0
      t.integer :light_ion_cannon, default: 0
      t.integer :heavy_ion_cannon, default: 0

      t.timestamps
    end
  end
end
