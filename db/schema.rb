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

ActiveRecord::Schema.define(version: 20160128001156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agencies", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "fax"
    t.string "email"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
  end

  create_table "coverage_types", force: :cascade do |t|
    t.string "description"
  end

  create_table "grant_coverage_types", force: :cascade do |t|
    t.integer "grant_id"
    t.integer "coverage_type_id"
    t.boolean "past_due"
  end

  create_table "grant_reasons", force: :cascade do |t|
    t.integer  "grant_id"
    t.integer  "reason_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grant_statuses", force: :cascade do |t|
    t.string "description"
  end

  create_table "grants", force: :cascade do |t|
    t.date     "application_date"
    t.string   "details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ehf_number"
    t.float    "total_rent"
    t.float    "adjusted_rent"
    t.boolean  "subsidized"
    t.integer  "subsidy_type_id"
    t.integer  "months_owed"
    t.float    "rent_owed"
    t.float    "security_deposit_owed"
    t.string   "utility_type_owed"
    t.float    "utility_owed"
    t.string   "status"
    t.float    "grant_amount"
    t.datetime "funding_date"
    t.integer  "residence_id"
    t.integer  "previous_residence_id"
    t.integer  "grant_status_id"
  end

  create_table "income_types", force: :cascade do |t|
    t.string "description"
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
    t.integer  "income_type_id"
  end

  create_table "other_payments", force: :cascade do |t|
    t.integer "grant_id"
    t.float   "amount"
    t.date    "date_paid"
    t.string  "description"
  end

  create_table "payees", force: :cascade do |t|
    t.integer "grant_id"
    t.string  "name"
    t.string  "attention"
    t.string  "street_address"
    t.string  "unit_number"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.string  "email"
    t.string  "phone"
    t.float   "check_amount"
    t.date    "check_date"
    t.string  "check_number"
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

  create_table "residence_types", force: :cascade do |t|
    t.string "description"
  end

  create_table "residences", force: :cascade do |t|
    t.string  "address"
    t.string  "unit_number"
    t.string  "city"
    t.string  "state"
    t.string  "zip"
    t.integer "residence_type_id"
    t.date    "move_in_date"
    t.date    "move_out_date"
    t.string  "reason_left"
    t.boolean "transitional_housing"
    t.float   "rent"
    t.float   "deposit"
    t.float   "amount_returned"
  end

  create_table "subsidy_types", force: :cascade do |t|
    t.string "description"
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

  add_foreign_key "grant_coverage_types", "coverage_types"
  add_foreign_key "grant_coverage_types", "grants"
  add_foreign_key "grant_reasons", "grants"
  add_foreign_key "grant_reasons", "reason_types"
  add_foreign_key "grants", "grant_statuses"
  add_foreign_key "grants", "residences"
  add_foreign_key "grants", "residences", column: "previous_residence_id"
  add_foreign_key "incomes", "income_types"
  add_foreign_key "incomes", "people"
  add_foreign_key "other_payments", "grants"
  add_foreign_key "people", "grants"
  add_foreign_key "residences", "residence_types"
end
