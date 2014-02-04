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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140204162146) do

  create_table "games_lists", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "pos"
    t.integer  "ttt_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.boolean  "p1"
  end

  create_table "ttts", :force => true do |t|
    t.string   "name"
    t.string   "p1"
    t.string   "p2"
    t.string   "completed"
    t.string   "locked"
    t.string   "opponent_username"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
    t.string   "opponent_email"
    t.string   "need_player"
    t.string   "turn_for_player_id"
    t.string   "winner_name"
    t.string   "p1_name"
    t.string   "p2_name"
  end

  create_table "ttts_users", :force => true do |t|
    t.integer "user_id"
    t.integer "ttt_id"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "last_name"
    t.string   "role"
    t.integer  "wins"
    t.integer  "losses"
    t.integer  "draws"
    t.string   "username"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "password_digest"
  end

end
