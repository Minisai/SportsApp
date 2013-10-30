class CreateAssigneePlans < ActiveRecord::Migration
  def change
    create_table :assignee_plans do |t|
      t.integer :assignee_id
      t.string :assignee_type
      t.integer :plan_id

      t.timestamps
    end

    add_index :assignee_plans, [:assignee_id, :assignee_type]
    add_index :assignee_plans, :plan_id
  end
end
