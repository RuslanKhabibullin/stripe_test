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

ActiveRecord::Schema.define(version: 2021_01_06_100607) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "title", null: false
    t.text "description"
    t.decimal "price", precision: 10, scale: 2, default: "0.0", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "payment_sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "item_id", null: false
    t.string "stripe_checkout_session_id"
    t.string "stripe_payment_intent_id"
    t.string "stripe_event_id"
    t.string "state", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["item_id"], name: "index_payment_sessions_on_item_id"
    t.index ["stripe_checkout_session_id"], name: "index_payment_sessions_on_stripe_checkout_session_id"
    t.index ["user_id"], name: "index_payment_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "customer_token"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_users_on_deleted_at"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "payment_sessions", "items"
  add_foreign_key "payment_sessions", "users"
end
