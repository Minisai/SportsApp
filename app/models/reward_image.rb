class RewardImage < ActiveRecord::Base
  validates :image, :creator, :presence => true

  mount_uploader :image, RewardImageUploader

  belongs_to :creator, :polymorphic => true
  has_many :rewards
end
