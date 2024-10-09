class MoveResourcesFromUserToPlanet < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :metal_resource
    remove_column :users, :crystal_resource
    remove_column :users, :deuterium_resource

    add_column :planets, :metal_resource, :numeric, default: 0
    add_column :planets, :crystal_resource, :numeric, default: 0
    add_column :planets, :deuterium_resource, :numeric, default: 0
  end
end
