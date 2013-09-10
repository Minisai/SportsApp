class CreatePricingPlans < ActiveRecord::Migration
  def change
    create_table :pricing_plans do |t|
      t.string :name
      t.integer :role_type
      t.integer :cost
      t.integer :duration

      t.timestamps
    end

    add_index :pricing_plans, :role_type
  end
end
