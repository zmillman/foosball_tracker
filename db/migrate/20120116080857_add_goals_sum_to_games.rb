class AddGoalsSumToGames < ActiveRecord::Migration
  def up
    add_column :games, :goals_count, :integer, :default => 0, :unsigned => true
    add_index :games, :goals_count
    
    Game.reset_column_information
    Game.find_each &:refresh_goal_cache
  end
  
  def down
    remove_column :games, :goals_count
  end
end
