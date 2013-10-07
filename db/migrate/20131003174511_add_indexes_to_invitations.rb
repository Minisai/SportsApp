class AddIndexesToInvitations < ActiveRecord::Migration
  def change
    add_index :invitations, :player_id
    add_index :invitations, :coach_id
  end
end
