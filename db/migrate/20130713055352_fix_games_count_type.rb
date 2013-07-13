class FixGamesCountType < ActiveRecord::Migration
  def up
    connection.execute(%q{
      alter table leagues
      alter column games_count
      type integer using cast(games_count as integer)
    })
    # change_column :leagues, :games_count, :integer, :default => 0
  end

  def down
    change_column :leagues, :games_count, :string
  end
end
