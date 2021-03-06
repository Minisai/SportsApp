class Coaches::PlayersController < ApplicationController
  respond_to :html, :json
  load_and_authorize_resource
  before_filter :load_coach
  before_filter :load_player, :only => [:show, :motivate, :send_message]

  def index
    @players = params[:team_id].present? ? @coach.players.with_team(params[:team_id]) : @coach.players.search(filter_params)
  end

  def invite
    result = @coach.invite_player_with(invitation_params)
    if result[:success]
      render :json => {:message => "Invitation was sent successfully" }
    else
      render :json => {:message => result[:message]}, :status => :bad_request
    end
  end

  def motivate
    motivation = @coach.find_or_create_motivation(motivation_params[:motivation])
    if motivation.try(:persisted?)
      @player.motivations << motivation
      render :json => {:message => "Motivation was sent successfully", :motivations => @coach.motivations}
    else
      render :json => {:message => "Select motivation or provide message"}, :status => :bad_request
    end
  end

  def send_message
    if params[:message].present?
      PlayerMailer.email_message(@player, @coach, params[:message]).deliver
      render :json => {:message => "Message was sent successfully"}
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

  def filter_params
    params.permit(:player_id, :country, :last_name)
  end

  def motivation_params
    params.permit(:motivation => [:id, :message])
  end

  def invitation_params
    params[:player].permit(:first_name, :last_name, :email)
  end
end
