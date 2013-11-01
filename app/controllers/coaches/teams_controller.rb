class Coaches::TeamsController < ApplicationController
  authorize_resource
  before_filter :load_coach
  def index
    @players = @coach.players
    @teams = @coach.teams
  end

  def show
    render :json => Team.find_by_id(params[:id]), :root => false
  end

  def create
    team = @coach.teams.build(team_params)
    if team.save
      render :json => {:teams => @coach.teams, :message => "Team was successfully created"}
    else
      render :json => {:message => team.errors.full_messages.join("")}, :status => :bad_request
    end
  end

  private
  def team_params
    params.permit(:name, :description)
  end

  def load_coach
    @coach = current_user.role
  end
end
