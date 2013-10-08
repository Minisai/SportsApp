class AddRewardImageIdToReward < ActiveRecord::Migration
  def change
    add_column :rewards, :reward_image_id, :integer
    add_index :rewards, :reward_image_id
  end
end
