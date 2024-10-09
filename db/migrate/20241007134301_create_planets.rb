class CreatePlanets < ActiveRecord::Migration[7.0]
  def change
    create_table :planets do |t|
      t.references :user, foreign_key: true, index: true
      t.text :name, default: ""
      t.integer :galaxy, default: 0
      t.integer :solar_system, default: 0
      t.integer :planet_position, default: 0
      t.integer :photo_number, default: 0

      t.timestamps
    end
  end
end
