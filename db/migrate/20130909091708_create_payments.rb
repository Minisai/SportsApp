class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :user_id
      t.integer :pricing_plan_id

      t.timestamps
    end

    add_index :payments, :user_id
    add_index :payments, :pricing_plan_id
  end
end
