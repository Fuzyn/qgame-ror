class CreateUserFleetsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :user_fleets do |t|
      t.references :user, foreign_key: true, index: true
      t.integer :cruiser, default: 0
      t.integer :heavy_fighter, default: 0
      t.integer :light_fighter, default: 0
      t.integer :warship, default: 0

      t.timestamps
    end
  end
end
