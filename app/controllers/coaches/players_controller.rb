class Coaches::PlayersController < ApplicationController
  respond_to :html, :json, :xml
  load_and_authorize_resource
  before_filter :get_coach
  before_filter :get_player, :only => [:show, :motivate, :send_message]

  def index
    @players = @coach.players
  end

  def motivate

  end

  def send_message
    if params[:message].present?
      PlayerMailer.email_message(@player, params[:message]).deliver
    end
  end

  private
  def get_coach
    @coach = current_user.role
  end

  def get_player
    @player = @coach.players.find(params[:id])
  end
end
