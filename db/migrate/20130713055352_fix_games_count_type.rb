class FixGamesCountType < ActiveRecord::Migration
  def up
    change_column :leagues, :games_count, :integer, :default => 0
  end

  def down
    change_column :leagues, :games_count, :string
  end
end
