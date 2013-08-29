class Coach < ActiveRecord::Base
  include RoleConcern

  has_many :players
end
