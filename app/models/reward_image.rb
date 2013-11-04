class RewardImage < ActiveRecord::Base
  include MayBeDefaultConcern

  validates :image, :creator, :presence => true

  mount_uploader :image, RewardImageUploader

  belongs_to :creator, :polymorphic => true
  has_many :rewards

  class << self
    def accessible_for(coach)
      RewardImage.default + coach.reward_images
    end
  end
end
