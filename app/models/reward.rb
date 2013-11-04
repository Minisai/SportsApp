class Reward < ActiveRecord::Base
  include MayBeDefaultConcern
  validates :name, :creator, :presence => true
  validates :name, :uniqueness => {:scope => [:creator_id, :creator_type]}

  belongs_to :creator, :polymorphic => true
  belongs_to :reward_image
  has_many :plan_items, :as => :item

  delegate :image_url, :to => :reward_image, :allow_nil => true
end
