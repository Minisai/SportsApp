class Coach < ActiveRecord::Base
  include RoleConcern

  has_many :players
  has_many :teams
  has_many :motivations
end
