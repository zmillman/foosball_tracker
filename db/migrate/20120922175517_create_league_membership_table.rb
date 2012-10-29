class CreateLeagueMembershipTable < ActiveRecord::Migration
  def up
    create_table :league_memberships, :force => true do |t|
      t.integer :league_id
      t.integer :user_id
      t.timestamps
    end
    
    add_index :league_memberships, :league_id
    add_index :league_memberships, :user_id
  end

  def self.down
    drop_table :league_memberships
  end
end