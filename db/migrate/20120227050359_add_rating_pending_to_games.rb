class AddRatingPendingToGames < ActiveRecord::Migration
  def change
    add_column :games, :rating_pending, :boolean, :default => true
  end
end
