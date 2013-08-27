class Parent < ActiveRecord::Base
  has_one :user, :as => :role
  has_many :players
end
