class CreateCoachPlayerTable < ActiveRecord::Migration
  def up
    create_table :coaches_players do |t|
      t.belongs_to :coach
      t.belongs_to :player
    end

    Player.find_each do |player|
      player.coaches << player.coach
    end

    remove_column :players, :coach_id
  end
  def down
    add_column :players, :coach_id, :integer

    Player.find_each do |player|
      player.coach = player.coaches.first
      player.save
    end

    drop_table :coaches_players
  end
end
