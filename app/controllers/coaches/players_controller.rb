class Coaches::PlayersController < ApplicationController
  respond_to :html, :json, :xml
  load_and_authorize_resource
  before_filter :load_coach
  before_filter :load_player, :only => [:show, :motivate, :send_message]

  def index
    @players = @coach.players
  end

  def motivate
  end

  def send_message
    if params[:message].present?
      PlayerMailer.email_message(@player, params[:message]).deliver
      render :json => {:message => "Message was sent successfully"}, :status => :ok
    else
      render :json => {:message => "Message required"}, :status => :bad_request
    end
  end

  private
  def load_coach
    @coach = current_user.role
  end

  def load_player
    @player = @coach.players.find(params[:id])
  end
end
