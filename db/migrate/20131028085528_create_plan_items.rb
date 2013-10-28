class CreatePlanItems < ActiveRecord::Migration
  def change
    create_table :plan_items do |t|
      t.integer :plan_id
      t.integer :item_id
      t.string  :item_type
      t.integer :position

      t.timestamps
    end

    add_index :plan_items, :plan_id
    add_index :plan_items, [:item_id, :item_type]
  end
end
