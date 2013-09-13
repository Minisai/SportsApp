class Angular::TemplatesController < ApplicationController
  def show
    render  params[:id], layout: false
  end
end
