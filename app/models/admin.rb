class Admin < ActiveRecord::Base
  include RoleConcern

  has_many :rewards, :as => :creator
  has_many :reward_images, :as => :creator
end
