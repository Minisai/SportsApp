class Coaches::RewardImagesController < ApplicationController
  authorize_resource
  before_filter :load_coach

  def create
    reward_image = @coach.reward_images.create(:image => params[:file])
    if reward_image.persisted?
      render :json => RewardImage.accessible_for(@coach)
    else
      render :json => {:message => 'You can upload only image (jpg, png, gif)'}, :status => :bad_request
    end
  end

  def destroy
    reward_image = @coach.reward_images.find(params[:id])
    if reward_image.destroy
      render :json => RewardImage.accessible_for(@coach)
    else
      render :json => {:message => reward_image.errors.full_messages.join}, :status => :bad_request
    end
  end

  private
  def load_coach
    @coach = current_user.role
  end
end
