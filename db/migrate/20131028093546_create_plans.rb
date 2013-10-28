class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.integer :coach_id
      t.string :name
      t.text :description

      t.timestamps
    end

    add_index :plans, :coach_id
  end
end
