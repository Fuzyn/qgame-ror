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

ActiveRecord::Schema[7.0].define(version: 2024_10_05_164652) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "user_defences", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "rocket_launcher", default: 0
    t.integer "light_laser_cannon", default: 0
    t.integer "heavy_laser_cannon", default: 0
    t.integer "light_ion_cannon", default: 0
    t.integer "heavy_ion_cannon", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_defences_on_user_id"
  end

  create_table "user_fleets", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "cruiser", default: 0
    t.integer "heavy_fighter", default: 0
    t.integer "light_fighter", default: 0
    t.integer "warship", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_user_fleets_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "metal_resource", default: "0.0"
    t.decimal "crystal_resource", default: "0.0"
    t.decimal "deuterium_resource", default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "user_defences", "users"
  add_foreign_key "user_fleets", "users"
end
