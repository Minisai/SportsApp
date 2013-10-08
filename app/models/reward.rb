class Reward < ActiveRecord::Base
  validates :name, :creator, :presence => true
  validates :name, :uniqueness => {:scope => [:creator_id, :creator_type]}

  belongs_to :creator, :polymorphic => true
  belongs_to :reward_image

  delegate :image, :to => :reward_image

  scope :default, -> { where(:creator_type => 'Admin') }

  def image_url
    if reward_image.present?
      reward_image.image.url
    end
  end
end
