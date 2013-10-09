class Coaches::RewardImagesController < ApplicationController
  authorize_resource

  def create
    reward_image = current_user.role.reward_images.create(:image => params[:file])
    if reward_image.persisted?
      render :json => RewardImage.accessible_for(current_user.role)
    else
      render :json => {:message => reward_image.errors.full_messages.join}, :status => :bad_request
    end
  end
end
