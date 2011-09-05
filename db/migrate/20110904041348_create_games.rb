class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.belongs_to :league

      t.timestamps
    end
  end
end
