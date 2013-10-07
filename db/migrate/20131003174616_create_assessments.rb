class CreateAssessments < ActiveRecord::Migration
  def change
    create_table :assessments do |t|
      t.string :name
      t.text :description
      t.integer :coach_id

      t.timestamps
    end

    add_index :assessments, :coach_id
  end
end
