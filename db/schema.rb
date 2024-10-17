# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_10_16_134500) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "build_queues", force: :cascade do |t|
    t.bigint "user_id"
    t.string "user_email"
    t.string "key"
    t.string "source"
    t.integer "quantity"
    t.datetime "end_time"
    t.string "secret_hash"
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_build_queues_on_user_id"
  end

  create_table "planet_buildings", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "metal_mine", default: 0
    t.integer "crystal_mine", default: 0
    t.integer "deuterium_refinery", default: 0
    t.integer "power_station", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "planet_id"
    t.index ["planet_id"], name: "index_planet_buildings_on_planet_id"
    t.index ["user_id"], name: "index_planet_buildings_on_user_id"
  end

  create_table "planet_defences", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "rocket_launcher", default: 0
    t.integer "light_laser_cannon", default: 0
    t.integer "heavy_laser_cannon", default: 0
    t.integer "light_ion_cannon", default: 0
    t.integer "heavy_ion_cannon", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "planet_id"
    t.index ["planet_id"], name: "index_planet_defences_on_planet_id"
    t.index ["user_id"], name: "index_planet_defences_on_user_id"
  end

  create_table "planet_fleets", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "cruiser", default: 0
    t.integer "heavy_fighter", default: 0
    t.integer "light_fighter", default: 0
    t.integer "warship", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "planet_id"
    t.index ["planet_id"], name: "index_planet_fleets_on_planet_id"
    t.index ["user_id"], name: "index_planet_fleets_on_user_id"
  end

  create_table "planets", force: :cascade do |t|
    t.bigint "user_id"
    t.text "name", default: ""
    t.integer "galaxy", default: 0
    t.integer "solar_system", default: 0
    t.integer "planet_position", default: 0
    t.integer "photo_number", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "metal_resource", default: "0.0"
    t.decimal "crystal_resource", default: "0.0"
    t.decimal "deuterium_resource", default: "0.0"
    t.index ["user_id"], name: "index_planets_on_user_id"
  end

  create_table "send_fleet_queues", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "planet_id"
    t.string "user_email"
    t.string "travel_type"
    t.integer "galaxy"
    t.integer "solar_system"
    t.integer "planet_position"
    t.integer "cruiser"
    t.integer "light_fighter"
    t.integer "heavy_fighter"
    t.integer "warship"
    t.integer "metal_resource"
    t.integer "crystal_resource"
    t.integer "deuterium_resource"
    t.datetime "end_time"
    t.string "secret_hash"
    t.string "direction"
    t.boolean "deleted", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["planet_id"], name: "index_send_fleet_queues_on_planet_id"
    t.index ["user_id"], name: "index_send_fleet_queues_on_user_id"
  end

  create_table "user_messages", force: :cascade do |t|
    t.bigint "user_id"
    t.text "title"
    t.text "message"
    t.text "message_type"
    t.datetime "read_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_messages_on_user_id"
  end

  create_table "user_technologies", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "combat_technology", default: 0
    t.integer "combustion_drive", default: 0
    t.integer "drive_technology", default: 0
    t.integer "energy_technology", default: 0
    t.integer "hyperspace_drive", default: 0
    t.integer "impulse_drive", default: 0
    t.integer "ion_technology", default: 0
    t.integer "laser_technology", default: 0
    t.integer "plasma_technology", default: 0
    t.integer "protective_technology", default: 0
    t.integer "rocket_technology", default: 0
    t.integer "storage_technology", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_technologies_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "build_queues", "users"
  add_foreign_key "planet_buildings", "planets"
  add_foreign_key "planet_buildings", "users"
  add_foreign_key "planet_defences", "planets"
  add_foreign_key "planet_defences", "users"
  add_foreign_key "planet_fleets", "planets"
  add_foreign_key "planet_fleets", "users"
  add_foreign_key "planets", "users"
  add_foreign_key "send_fleet_queues", "planets"
  add_foreign_key "send_fleet_queues", "users"
  add_foreign_key "user_messages", "users"
  add_foreign_key "user_technologies", "users"
end
