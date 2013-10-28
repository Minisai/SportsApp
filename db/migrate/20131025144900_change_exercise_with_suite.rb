class ChangeExerciseWithSuite < ActiveRecord::Migration
  def change
    remove_column :exercises, :assessment_id, :integer

    add_column :exercises, :suite_id, :integer
    add_column :exercises, :suite_type, :string
    add_index :exercises, [:suite_id, :suite_type]
  end
end
