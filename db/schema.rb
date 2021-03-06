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

ActiveRecord::Schema.define(version: 20140422233803) do

  create_table "anon_users", force: true do |t|
    t.string   "ip"
    t.string   "visited_page"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answered_factors", force: true do |t|
    t.integer  "factor_id"
    t.integer  "answer_id"
    t.float    "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "statistic_id"
    t.integer  "month"
    t.integer  "year"
  end

  create_table "answers", force: true do |t|
    t.float    "amount"
    t.integer  "user_id"
    t.integer  "statistic_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.integer  "month"
    t.integer  "year"
  end

  create_table "badges", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "earned_badges", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "badge_id"
  end

  create_table "factors", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "dependency"
    t.integer  "statistic_id"
    t.string   "variableName"
    t.integer  "type"
    t.string   "unit"
    t.float    "amount"
    t.integer  "category_id"
  end

  create_table "missions", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "value"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "times_completed"
    t.integer  "min_rank"
    t.integer  "category_id"
  end

  create_table "region_statistics", force: true do |t|
    t.integer  "region_id"
    t.float    "amount"
    t.string   "stat_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "short_name"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], name: "index_roles_on_name"

  create_table "statistics", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "equation"
    t.string   "description"
    t.integer  "usage_type_id"
    t.integer  "category_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "region_id"
    t.string   "firstName"
    t.string   "lastName"
    t.string   "state"
    t.string   "visited_page"
    t.integer  "rank"
    t.integer  "score"
    t.integer  "effective_score"
    t.integer  "wallpaper_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "users_roles", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"

end
