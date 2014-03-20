# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140320121002) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: true do |t|
    t.integer  "user_id",                               null: false
    t.decimal  "amount",        precision: 5, scale: 2, null: false
    t.integer  "bookable_id"
    t.string   "bookable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "infotext"
  end

  add_index "bookings", ["bookable_id", "bookable_type"], name: "bookable", using: :btree

  create_table "deliveries", force: true do |t|
    t.integer  "product_id",                         null: false
    t.integer  "quantity",                           null: false
    t.decimal  "unit_price", precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "order_items", force: true do |t|
    t.integer  "amount"
    t.integer  "order_id",    null: false
    t.integer  "delivery_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.decimal  "size",                 precision: 5, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",              default: "", null: false
    t.string   "encrypted_password", default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
