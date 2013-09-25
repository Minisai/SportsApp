class AddIndexesToHabtmTables < ActiveRecord::Migration
  def change
    add_index :players_teams, [:player_id, :team_id]
    add_index :players_teams, :player_id
    add_index :players_teams, :team_id

    add_index :coaches_players, [:coach_id, :player_id]
    add_index :coaches_players, :coach_id
    add_index :coaches_players, :player_id
  end
end
