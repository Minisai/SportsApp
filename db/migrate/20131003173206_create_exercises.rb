class CreateExercises < ActiveRecord::Migration
  def change
    create_table :exercises do |t|
      t.integer :repetitions, :default => 1
      t.integer :drill_id
      t.integer :assessment_id

      t.timestamps
    end
    add_index :exercises, :drill_id
    add_index :exercises, :assessment_id
  end
end
