class CreateSendFleetQueue < ActiveRecord::Migration[7.0]
  def change
    create_table :send_fleet_queues do |t|
      t.references :user, foreign_key: true, index: true
      t.references :planet, foreign_key: true, index: true
      t.string :user_email
      t.string :travel_type
      t.integer :galaxy
      t.integer :solar_system
      t.integer :planet_position
      t.integer :cruiser
      t.integer :light_fighter
      t.integer :heavy_fighter
      t.integer :warship
      t.integer :metal_resource
      t.integer :crystal_resource
      t.integer :deuterium_resource
      t.datetime :end_time
      t.string :secret_hash
      t.string :direction
      t.boolean :deleted, default: false

      t.timestamps
    end
  end
end
