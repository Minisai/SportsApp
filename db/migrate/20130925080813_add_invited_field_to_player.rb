class AddInvitedFieldToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :invited, :boolean, :default => false
  end
end
