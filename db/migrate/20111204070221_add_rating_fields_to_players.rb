class AddRatingFieldsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :skill_mean, :decimal, :precision => 12, :scale => 5, :default => 0.0
    add_column :players, :skill_deviation, :decimal, :precision => 12, :scale => 5, :default => 0.0
  end
end
