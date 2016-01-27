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

ActiveRecord::Schema.define(version: 20160127033142) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "grant_reasons", force: :cascade do |t|
    t.integer  "grant_id"
    t.integer  "reason_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grants", force: :cascade do |t|
    t.date     "application_date"
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "status"
    t.float    "grant_amount"
    t.string   "check_number"
    t.string   "payee"
    t.datetime "funding_date"
  end

  create_table "incomes", force: :cascade do |t|
    t.integer  "person_id"
    t.boolean  "current"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "employer"
    t.string   "occupation"
    t.float    "monthly_income"
    t.string   "reason_for_leaving"
    t.boolean  "disabled"
    t.boolean  "full_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.integer  "grant_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "phone"
    t.date     "birth_date"
    t.boolean  "veteran"
    t.boolean  "student"
    t.boolean  "full_time_student"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reason_types", force: :cascade do |t|
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",     null: false
    t.string   "encrypted_password",     default: "",     null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,      null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.string   "role",                   default: "user", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "grant_reasons", "grants"
  add_foreign_key "grant_reasons", "reason_types"
  add_foreign_key "incomes", "people"
  add_foreign_key "people", "grants"
end
