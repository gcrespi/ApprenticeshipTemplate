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

ActiveRecord::Schema.define(version: 20161006162518) do

  create_table "board_positions", force: :cascade do |t|
    t.integer  "x_coordinate"
    t.integer  "y_coordinate"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "board_id"
  end

  create_table "board_states", force: :cascade do |t|
    t.string   "winner_player"
    t.string   "type"
    t.integer  "board_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "playing_player"
    t.string   "waiting_player"
  end

  create_table "boards", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "moves", force: :cascade do |t|
    t.integer  "board_id"
    t.string   "player"
    t.integer  "board_position_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

end
