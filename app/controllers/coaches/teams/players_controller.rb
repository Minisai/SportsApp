class Coaches::Teams::PlayersController < ApplicationController
  authorize_resource
  before_filter :load_coach
  before_filter :load_team

  def create
    player = @coach.players.find(params[:player_id])
    if player.update_attributes(:team => @team)
      render :json => @team.players
    else
      render :json => {:message => "Can't add player to team"}, :status => :bad_request
    end
  end

  def destroy
    player = @team.players.find(params[:id])
    if player.update_attributes(:team => nil)
      render :json => @team.players
    else
      render :json => {:message => "Can't remove player from team"}, :status => :bad_request
    end
  end

  private

  def load_coach
    @coach = current_user.role
  end

  def load_team
    @team = @coach.teams.find(params[:team_id])
  end
end