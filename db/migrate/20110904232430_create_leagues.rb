class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.string :name
      t.references :owner
      t.text :description
      
      t.timestamps
    end
  end
end
