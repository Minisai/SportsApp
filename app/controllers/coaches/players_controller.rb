class Coaches::PlayersController < ApplicationController
  respond_to :html, :json, :xml
  load_and_authorize_resource
  before_filter :get_coach

  def index
    @players = @coach.players
  end

  def show
    @player = @coach.players.find(params[:id])
  end

  private
  def get_coach
    @coach = current_user.role
  end
end
