class CreateUserTechnologies < ActiveRecord::Migration[7.0]
  def change
    create_table :user_technologies do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :combat_technology, default: 0
      t.integer :combustion_drive, default: 0
      t.integer :drive_technology, default: 0
      t.integer :energy_technology, default: 0
      t.integer :hyperspace_drive, default: 0
      t.integer :impulse_drive, default: 0
      t.integer :ion_technology, default: 0
      t.integer :laser_technology, default: 0
      t.integer :plasma_technology, default: 0
      t.integer :protective_technology, default: 0
      t.integer :rocket_technology, default: 0
      t.integer :storage_technology, default: 0

      t.timestamps
    end
  end
end
