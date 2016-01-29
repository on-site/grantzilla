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

ActiveRecord::Schema.define(version: 20160129002837) do

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

  create_table "budgets", force: :cascade do |t|
    t.float    "earned_income1"
    t.float    "unearned_income1"
    t.float    "earned_income2"
    t.float    "unearned_income2"
    t.float    "other_household_income"
    t.float    "child_support"
    t.float    "food_stamps"
    t.float    "security_deposit_refund"
    t.float    "rent"
    t.float    "utilities"
    t.float    "phone"
    t.float    "food"
    t.float    "health_insurance"
    t.float    "medical"
    t.float    "auto_loan"
    t.float    "auto_insurance"
    t.float    "auto_expenses"
    t.float    "public_transportation"
    t.float    "child_care"
    t.float    "clothing"
    t.float    "toiletries"
    t.float    "household"
    t.float    "television"
    t.float    "internet"
    t.float    "installment_payments"
    t.string   "installment_payment_description"
    t.float    "miscellaneous_expenses"
    t.string   "miscellaneous_expenses_description"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "grant_id"
    t.text     "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "coverage_types", force: :cascade do |t|
    t.string "description"
  end

  create_table "coverage_types_grants", force: :cascade do |t|
    t.integer "coverage_type_id"
    t.integer "grant_id"
  end

  add_index "coverage_types_grants", ["coverage_type_id"], name: "index_coverage_types_grants_on_coverage_type_id", using: :btree
  add_index "coverage_types_grants", ["grant_id"], name: "index_coverage_types_grants_on_grant_id", using: :btree

  create_table "data_import_history_logs", force: :cascade do |t|
    t.integer  "ehf_records_processed"
    t.integer  "ehf_records_imported"
    t.text     "errors"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "grant_statuses", force: :cascade do |t|
    t.string "description"
  end

  create_table "grants", force: :cascade do |t|
    t.date     "application_date"
    t.text     "details"
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
    t.float    "grant_amount"
    t.datetime "funding_date"
    t.integer  "residence_id"
    t.integer  "previous_residence_id"
    t.integer  "grant_status_id"
    t.integer  "user_id"
    t.integer  "last_month_budget_id"
    t.integer  "current_month_budget_id"
    t.integer  "next_month_budget_id"
    t.string   "step"
  end

  create_table "grants_reason_types", force: :cascade do |t|
    t.integer "grant_id"
    t.integer "reason_type_id"
  end

  add_index "grants_reason_types", ["grant_id"], name: "index_grants_reason_types_on_grant_id", using: :btree
  add_index "grants_reason_types", ["reason_type_id"], name: "index_grants_reason_types_on_reason_type_id", using: :btree

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
    t.string   "cell"
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

  create_table "uploads", force: :cascade do |t|
    t.integer  "user_id",           null: false
    t.string   "user_type",         null: false
    t.string   "description"
    t.string   "category"
    t.string   "file_fingerprint",  null: false
    t.string   "file_file_name",    null: false
    t.string   "file_content_type", null: false
    t.integer  "file_file_size",    null: false
    t.datetime "file_updated_at",   null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "uploads", ["user_type", "user_id"], name: "index_uploads_on_user_type_and_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",            null: false
    t.string   "encrypted_password",     default: "",            null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,             null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "role",                   default: "case_worker", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "agency_id"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,             null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "validated",              default: 0,             null: false
  end

  add_index "users", ["agency_id"], name: "index_users_on_agency_id", using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "coverage_types_grants", "coverage_types"
  add_foreign_key "coverage_types_grants", "grants", on_delete: :cascade
  add_foreign_key "grants", "budgets", column: "current_month_budget_id"
  add_foreign_key "grants", "budgets", column: "last_month_budget_id"
  add_foreign_key "grants", "budgets", column: "next_month_budget_id"
  add_foreign_key "grants", "grant_statuses"
  add_foreign_key "grants", "residences"
  add_foreign_key "grants", "residences", column: "previous_residence_id"
  add_foreign_key "grants_reason_types", "grants", on_delete: :cascade
  add_foreign_key "grants_reason_types", "reason_types"
  add_foreign_key "incomes", "income_types"
  add_foreign_key "incomes", "people", on_delete: :cascade
  add_foreign_key "other_payments", "grants", on_delete: :cascade
  add_foreign_key "people", "grants", on_delete: :cascade
  add_foreign_key "residences", "residence_types"
  add_foreign_key "users", "agencies"
end
