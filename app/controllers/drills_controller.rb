class DrillsController < ApplicationController
  respond_to :html, :json, :xml

  def show
    render :json => Drill.find(params[:id])
  end
end
