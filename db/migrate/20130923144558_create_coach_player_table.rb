class CreateCoachPlayerTable < ActiveRecord::Migration
  def up
    create_table :coaches_players do |t|
      t.belongs_to :coach
      t.belongs_to :player
    end

    if Player.method_defined? :coach
      Player.find_each do |player|
        player.coaches << player.coach
      end
    end

    remove_column :players, :coach_id
  end
  def down
    add_column :players, :coach_id, :integer

    if Player.method_defined? :coaches
      Player.find_each do |player|
        player.coach = player.coaches.first
        player.save
      end
    end

    drop_table :coaches_players
  end
end
