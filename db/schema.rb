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

ActiveRecord::Schema.define(:version => 20130713055352) do

  create_table "games", :force => true do |t|
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "goals_count",    :default => 0
    t.boolean   "rating_pending", :default => true
    t.integer   "league_id"
  end

  add_index "games", ["goals_count"], :name => "index_games_on_goals_count"
  add_index "games", ["league_id"], :name => "index_games_on_league_id"

  create_table "league_memberships", :force => true do |t|
    t.integer   "league_id"
    t.integer   "user_id"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "league_memberships", ["league_id"], :name => "index_league_memberships_on_league_id"
  add_index "league_memberships", ["user_id"], :name => "index_league_memberships_on_user_id"

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.integer  "games_count", :limit => 255, :default => 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", :force => true do |t|
    t.integer   "team_id"
    t.integer   "user_id"
    t.string    "position",        :default => "Offense"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.decimal   "skill_mean",      :default => 0.0
    t.decimal   "skill_deviation", :default => 0.0
  end

  create_table "sessions", :force => true do |t|
    t.string    "email"
    t.string    "password"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "teams", :force => true do |t|
    t.integer   "game_id"
    t.integer   "goals",      :default => 0
    t.boolean   "is_winner",  :default => false
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string    "name"
    t.string    "email"
    t.string    "password_digest"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
