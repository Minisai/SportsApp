class CreateRewards < ActiveRecord::Migration
  def change
    create_table :rewards do |t|
      t.integer :creator_id
      t.integer :creator_type
      t.string :name
      t.text :description

      t.timestamps
    end

    add_index :rewards, [:creator_id, :creator_type]
  end
end
