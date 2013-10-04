class Coaches::DrillsController < ApplicationController
  respond_to :html, :json, :xml
  load_and_authorize_resource

  def show
    render :json => Drill.find(params[:id])
  end

  def create

  end
end
