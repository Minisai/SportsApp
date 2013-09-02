class DeviseCreateUsers < ActiveRecord::Migration
  def change
    create_table(:users) do |t|
      t.string :email,              :null => false, :default => ""
      t.string :username,           :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      t.string   :reset_password_token
      t.datetime :reset_password_sent_at

      t.string :name
      t.datetime :birthday
      t.string :country

      t.integer :role_id
      t.string :role_type

      t.boolean :male, :default => true
      t.boolean :paid, :default => false

      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
  end
end
