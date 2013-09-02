class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :token
      t.integer :coach_id
      t.integer :parent_id

      t.timestamps
    end
  end
end
