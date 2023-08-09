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

ActiveRecord::Schema[7.0].define(version: 2023_04_30_165441) do
  create_table "flight_details", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "pnr"
    t.string "fare_class"
    t.date "travel_date"
    t.integer "pax"
    t.date "ticketing_date"
    t.string "email"
    t.string "mobile_phone"
    t.string "booked_cabin"
    t.string "discount_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "error_messages", default: "--- []\n"
  end

end
