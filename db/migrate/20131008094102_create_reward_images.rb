class CreateRewardImages < ActiveRecord::Migration
  def change
    create_table :reward_images do |t|
      t.string :image
      t.integer :creator_id
      t.string :creator_type

      t.timestamps
    end

    add_index :reward_images, [:creator_id, :creator_type]
  end
end
