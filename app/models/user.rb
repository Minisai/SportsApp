class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :validatable

  validates :username, :name, :male, :birthday, :country, :role, :presence => true
  validates :username, :uniqueness => true

  belongs_to :role, :polymorphic => true
end
