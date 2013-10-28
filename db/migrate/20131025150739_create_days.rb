class CreateDays < ActiveRecord::Migration
  def change
    create_table :days do |t|
      t.integer :plan_session_id

      t.timestamps
    end

    add_index :days, :plan_session_id
  end
end
