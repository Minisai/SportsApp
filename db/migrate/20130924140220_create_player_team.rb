class CreatePlayerTeam < ActiveRecord::Migration
  def up
    create_table :players_teams do |t|
      t.belongs_to :team
      t.belongs_to :player
    end

    if Player.method_defined? :team
      Player.find_each do |player|
        player.teams << player.team if player.team.present?
      end
    end

    remove_column :players, :team_id
  end
  def down
    add_column :players, :team_id, :integer

    if Player.method_defined? :teams
      Player.find_each do |player|
        player.team = player.teams.first
        player.save
      end
    end

    drop_table :players_teams
  end
end
