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

ActiveRecord::Schema[7.0].define(version: 2022_05_28_012309) do
  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "budgets", force: :cascade do |t|
    t.integer "carrier_id", null: false
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "deadline"
    t.index ["carrier_id"], name: "index_budgets_on_carrier_id"
  end

  create_table "carriers", force: :cascade do |t|
    t.string "trade_name"
    t.string "corporate_name"
    t.string "domain"
    t.integer "nif"
    t.string "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "city"
    t.string "state"
    t.integer "status", default: 0
  end

  create_table "deadlines", force: :cascade do |t|
    t.integer "working_days"
    t.integer "min_distance"
    t.integer "max_distance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carrier_id", null: false
    t.index ["carrier_id"], name: "index_deadlines_on_carrier_id"
  end

  create_table "orders", force: :cascade do |t|
    t.decimal "volume"
    t.integer "product_weight"
    t.string "delivery_address"
    t.string "recipient_name"
    t.integer "carrier_id", null: false
    t.string "code"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_orders_on_carrier_id"
  end

  create_table "prices", force: :cascade do |t|
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "volume_id", null: false
    t.integer "weight_id", null: false
    t.integer "carrier_id", null: false
    t.index ["carrier_id"], name: "index_prices_on_carrier_id"
    t.index ["volume_id"], name: "index_prices_on_volume_id"
    t.index ["weight_id"], name: "index_prices_on_weight_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "carrier_id", null: false
    t.string "name"
    t.index ["carrier_id"], name: "index_users_on_carrier_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vehicles", force: :cascade do |t|
    t.string "license_plate"
    t.string "brand"
    t.string "model"
    t.integer "fabrication_year"
    t.integer "max_capacity"
    t.integer "carrier_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["carrier_id"], name: "index_vehicles_on_carrier_id"
  end

  create_table "volumes", force: :cascade do |t|
    t.decimal "min"
    t.decimal "max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  create_table "weights", force: :cascade do |t|
    t.integer "min"
    t.integer "max"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

  add_foreign_key "budgets", "carriers"
  add_foreign_key "deadlines", "carriers"
  add_foreign_key "orders", "carriers"
  add_foreign_key "prices", "carriers"
  add_foreign_key "prices", "volumes"
  add_foreign_key "prices", "weights"
  add_foreign_key "users", "carriers"
  add_foreign_key "vehicles", "carriers"
end
