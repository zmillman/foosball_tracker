class DropLeagues < ActiveRecord::Migration
  def self.up
    remove_column :games, :league_id

    drop_table :league_memberships

    drop_table :leagues
  end

  def self.down
    create_table "leagues", :force => true do |t|
      t.string   "name"
      t.integer  "owner_id"
      t.text     "description"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    create_table :league_memberships, :force => true do |t|
      t.integer  "user_id"
      t.integer  "league_id"
      t.datetime "created_at"
      t.datetime "updated_at"
    end

    add_column :games, :league_id, :integer
  end
end
