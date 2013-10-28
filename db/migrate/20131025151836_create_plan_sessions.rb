class CreatePlanSessions < ActiveRecord::Migration
  def change
    create_table :plan_sessions do |t|
      t.timestamps
    end
  end
end
