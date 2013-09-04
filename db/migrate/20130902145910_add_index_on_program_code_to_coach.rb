class AddIndexOnProgramCodeToCoach < ActiveRecord::Migration
  def change
    add_index :coaches, :program_code
  end
end
