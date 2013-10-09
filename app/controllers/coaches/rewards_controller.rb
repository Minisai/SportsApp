class Coaches::RewardsController < ApplicationController
  authorize_resource

  before_filter :load_coach

  def index
    @rewards = @coach.rewards
    @default_rewards = Reward.default
    @reward_images = RewardImage.accessible_for(@coach)
  end

  private
  def load_coach
    @coach = current_user.role
  end
end
