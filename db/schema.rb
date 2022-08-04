# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_08_04_131011) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cars", force: :cascade do |t|
    t.string "brand"
    t.string "model"
    t.string "name"
    t.integer "kilometers"
    t.float "purchased_price"
    t.date "purchased_date"
    t.float "total_cost"
    t.bigint "garage_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["garage_id"], name: "index_cars_on_garage_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "price"
    t.date "starting_date"
    t.date "ending_date"
    t.bigint "car_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_contracts_on_car_id"
  end

  create_table "garages", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_garages_on_user_id"
  end

  create_table "invoices", force: :cascade do |t|
    t.string "name"
    t.string "supplier"
    t.string "piece"
    t.float "price"
    t.integer "kilometers"
    t.date "date"
    t.bigint "car_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_invoices_on_car_id"
  end

  create_table "trips", force: :cascade do |t|
    t.bigint "car_id", null: false
    t.string "name"
    t.string "type"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["car_id"], name: "index_trips_on_car_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "nickname"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cars", "garages"
  add_foreign_key "contracts", "cars"
  add_foreign_key "garages", "users"
  add_foreign_key "invoices", "cars"
  add_foreign_key "trips", "cars"
end
