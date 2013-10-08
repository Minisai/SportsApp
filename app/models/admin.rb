class Admin < ActiveRecord::Base
  include RoleConcern

  has_many :rewards, :as => :creator
end
