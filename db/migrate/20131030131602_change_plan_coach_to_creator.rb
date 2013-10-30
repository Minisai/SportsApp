class ChangePlanCoachToCreator < ActiveRecord::Migration
  def up
    remove_column :plans, :coach_id
    add_column :plans, :creator_id, :integer
    add_column :plans, :creator_type, :string
    add_index :plans, [:creator_id, :creator_type]
  end

  def down
    remove_column :plans, :creator_id
    remove_column :plans, :creator_type
    add_column :plans, :coach_id, :integer
    add_index :plans, :coach_id
  end
end
