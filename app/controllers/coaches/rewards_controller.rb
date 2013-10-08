class Coaches::RewardsController < ApplicationController
  authorize_resource

  before_filter :load_coach

  def index
    @rewards = @coach.rewards
    @default_rewards = Reward.default
  end

  private
  def load_coach
    @coach = current_user.role
  end
end
