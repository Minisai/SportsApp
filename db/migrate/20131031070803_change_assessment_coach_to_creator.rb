class ChangeAssessmentCoachToCreator < ActiveRecord::Migration
  def up
    remove_column :assessments, :coach_id
    add_column :assessments, :creator_id, :integer
    add_column :assessments, :creator_type, :string
    add_index :assessments, [:creator_id, :creator_type]
  end

  def down
    remove_column :assessments, :creator_id
    remove_column :assessments, :creator_type
    add_column :assessments, :coach_id, :integer
    add_index :assessments, :coach_id
  end
end
