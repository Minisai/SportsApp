class CreateMotivations < ActiveRecord::Migration
  def change
    create_table :motivations do |t|
      t.text :message
      t.integer :coach_id

      t.timestamps
    end

    add_index :motivations, :coach_id
  end
end
