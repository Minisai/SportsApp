class CreateCoaches < ActiveRecord::Migration
  def change
    create_table :coaches do |t|
      t.string :program_code

      t.timestamps
    end
  end
end
