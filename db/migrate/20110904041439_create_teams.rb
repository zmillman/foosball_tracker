class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.references :game
      t.integer :goals, :default => 0
      t.boolean :is_winner, :default => false
      t.timestamps
    end
  end
end
