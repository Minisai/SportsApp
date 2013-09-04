class CreateMotivationsPlayers < ActiveRecord::Migration
  def change
    create_table :motivations_players do |t|
      t.integer :player_id
      t.integer :motivation_id
    end
    add_index :motivations_players, [:player_id, :motivation_id]
    add_index :motivations_players, :player_id
  end
end
