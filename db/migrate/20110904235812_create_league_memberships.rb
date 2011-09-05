class CreateLeagueMemberships < ActiveRecord::Migration
  def change
    create_table :league_memberships do |t|
      t.references :user
      t.references :league

      t.timestamps
    end
  end
end
