class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :game
      t.integer :goals, :default => 0
      t.boolean :is_winner, :default => false
      t.timestamps
    end
  end
end
