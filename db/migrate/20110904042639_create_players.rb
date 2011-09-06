class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.belongs_to :team
      t.belongs_to :user
      
      t.string :position, :default => 'Offense'
      
      t.timestamps
    end
  end
end
