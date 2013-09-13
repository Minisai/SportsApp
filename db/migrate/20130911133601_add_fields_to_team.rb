class AddFieldsToTeam < ActiveRecord::Migration
  def change
    add_column :teams, :description, :text
    add_column :teams, :program_code, :string
  end
end
