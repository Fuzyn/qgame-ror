class AddResourcesToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :metal_resource, :numeric, default: 0
    add_column :users, :crystal_resource, :numeric, default: 0
    add_column :users, :deuterium_resource, :numeric, default: 0
  end
end
