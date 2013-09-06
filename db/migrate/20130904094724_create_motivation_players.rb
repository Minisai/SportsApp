class CreateMotivationPlayers < ActiveRecord::Migration
  def change
    create_table :motivation_players do |t|
      t.integer :player_id
      t.integer :motivation_id
    end
    add_index :motivation_players, [:player_id, :motivation_id]
    add_index :motivation_players, :player_id
  end
end
