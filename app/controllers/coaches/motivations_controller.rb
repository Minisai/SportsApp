class Coaches::MotivationsController < ApplicationController
  respond_to :html, :json, :xml
  load_and_authorize_resource

  def index
    render :json => current_user.role.motivations, :root => false
  end
end
