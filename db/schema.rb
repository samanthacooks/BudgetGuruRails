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

ActiveRecord::Schema.define(version: 20170703143745) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "account", null: false
    t.integer "balance", null: false
    t.string "bank_name", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bills", force: :cascade do |t|
    t.string "bill_name", null: false
    t.string "status", null: false
    t.boolean "recurring", default: true, null: false
    t.integer "amount", null: false
    t.integer "due_date", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "budgets", force: :cascade do |t|
    t.string "budget_name", null: false
    t.integer "monthly_spend", null: false
    t.boolean "goal", default: false, null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goals", force: :cascade do |t|
    t.string "goal_name", null: false
    t.integer "amount_saved", null: false
    t.datetime "timeframe", null: false
    t.boolean "achieved", default: false, null: false
    t.integer "total", null: false
    t.integer "budget_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "incomes", force: :cascade do |t|
    t.string "source", null: false
    t.integer "post_tax_amount", null: false
    t.boolean "fixed", default: true, null: false
    t.string "pay_schedule"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.string "password_digest", null: false
    t.integer "balance_floor", null: false
    t.boolean "positive", default: false, null: false
    t.integer "remaining_balance", default: 0, null: false
    t.string "access_token"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
