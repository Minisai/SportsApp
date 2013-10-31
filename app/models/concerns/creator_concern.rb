module CreatorConcern
  extend ActiveSupport::Concern

  included do
    has_many :rewards, :as => :creator, :dependent => :destroy
    has_many :reward_images, :as => :creator, :dependent => :destroy
    has_many :plans, :as => :creator, :dependent => :destroy
    has_many :assessments, :as => :creator, :dependent => :destroy
  end
end