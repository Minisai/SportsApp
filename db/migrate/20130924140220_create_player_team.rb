class CreatePlayerTeam < ActiveRecord::Migration
  def up
    create_table :players_teams do |t|
      t.belongs_to :team
      t.belongs_to :player
    end

    Player.find_each do |player|
      player.teams << player.team if player.team.present?
    end

    remove_column :players, :team_id
  end
  def down
    add_column :players, :team_id, :integer

    Player.find_each do |player|
      player.team = player.teams.first
      player.save
    end

    drop_table :players_teams
  end
end
