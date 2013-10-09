class Coaches::RewardsController < ApplicationController
  authorize_resource
  before_filter :load_coach
  before_filter :load_reward, :only => [:update, :destroy]

  def index
    @rewards = @coach.rewards
    @default_rewards = Reward.default
    @reward_images = RewardImage.accessible_for(@coach)
  end

  def create
    reward = @coach.rewards.create(reward_params)
    if reward.persisted?
      render :json => @coach.rewards
    else
      render :json => {:message => reward.errors.full_messages.join}, :status => :bad_request
    end
  end

  def update
    if @reward.update_attributes(reward_params)
      render :json => @coach.rewards
    else
      render :json => {:message => @reward.errors.full_messages.join}, :status => :bad_request
    end
  end

  def destroy
    if @reward.destroy
      render :json => @coach.rewards
    else
      render :json => {:message => @reward.errors.full_messages.join}, :status => :bad_request
    end
  end

  private
  def reward_params
    params[:reward].permit(:name, :description, :reward_image_id)
  end

  def load_coach
    @coach = current_user.role
  end

  def load_reward
    @reward = @coach.rewards.find(params[:id])
  end
end
