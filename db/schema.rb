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

ActiveRecord::Schema.define(version: 20130904094724) do

  create_table "coaches", force: true do |t|
    t.string   "program_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "coaches", ["program_code"], name: "index_coaches_on_program_code", using: :btree

  create_table "motivations", force: true do |t|
    t.text     "message"
    t.integer  "coach_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "motivations", ["coach_id"], name: "index_motivations_on_coach_id", using: :btree

  create_table "motivations_players", force: true do |t|
    t.integer "player_id"
    t.integer "motivation_id"
  end

  add_index "motivations_players", ["player_id", "motivation_id"], name: "index_motivations_players_on_player_id_and_motivation_id", using: :btree
  add_index "motivations_players", ["player_id"], name: "index_motivations_players_on_player_id", using: :btree

  create_table "parents", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "token"
    t.integer  "coach_id"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.integer  "coach_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "username",               default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string   "name"
    t.datetime "birthday"
    t.string   "country"
    t.integer  "role_id"
    t.string   "role_type"
    t.boolean  "male",                   default: true
    t.boolean  "paid",                   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "sign_in_count",          default: 0
    t.time     "current_sign_in_at"
    t.time     "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
