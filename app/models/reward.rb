class Reward < ActiveRecord::Base
  validates :name, :creator, :presence => true
  validates :name, :uniqueness => {:scope => [:creator_id, :creator_type]}

  belongs_to :creator, :polymorphic => true
  belongs_to :reward_image
end
