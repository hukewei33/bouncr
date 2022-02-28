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

ActiveRecord::Schema.define(version: 2022_02_28_161637) do

  create_table "events", force: :cascade do |t|
    t.string "name"
    t.datetime "startTime"
    t.datetime "endTime"
    t.string "street1"
    t.string "street2"
    t.string "city"
    t.integer "zip"
    t.text "description"
    t.boolean "attendenceVisible"
    t.boolean "friendsAttendingVisible"
    t.integer "attendenceCap"
    t.integer "coverCharge"
    t.boolean "isOpenInvite"
    t.float "venueLatitude"
    t.float "venueLongitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "hosts", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_hosts_on_event_id"
    t.index ["user_id"], name: "index_hosts_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "event_id", null: false
    t.datetime "checkinTime"
    t.boolean "inviteStatus"
    t.boolean "checkinStatus"
    t.integer "phoneNumber"
    t.integer "coverChargePaid"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id"], name: "index_invites_on_event_id"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
    t.string "firstName"
    t.string "lastName"
    t.integer "phoneNumber"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "hosts", "events"
  add_foreign_key "hosts", "users"
  add_foreign_key "invites", "events"
  add_foreign_key "invites", "users"
end
