class CreateInvitations < ActiveRecord::Migration
  def change
    create_table :invitations do |t|
      t.integer :player_id
      t.integer :coach_id
      t.integer :status

      t.timestamps
    end
  end
end
