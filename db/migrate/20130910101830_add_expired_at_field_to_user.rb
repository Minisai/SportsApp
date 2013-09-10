class AddExpiredAtFieldToUser < ActiveRecord::Migration
  def change
    remove_column :users, :paid
    add_column :users, :expired_at, :datetime
  end
end
