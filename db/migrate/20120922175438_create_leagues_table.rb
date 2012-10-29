class CreateLeaguesTable < ActiveRecord::Migration
  def change
    create_table :leagues, :force => true do |t|
      t.string :name
      t.string :games_count
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end