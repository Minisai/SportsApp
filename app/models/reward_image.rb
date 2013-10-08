class RewardImage < ActiveRecord::Base
  validates :image, :creator, :presence => true

  belongs_to :creator, :polymorphic => true
  has_many :rewards
end
