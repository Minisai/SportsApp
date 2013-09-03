class Coaches::DashboardsController < ApplicationController
  def show
    @team = current_user.role.teams.first
    @players = @team.players.paginate(:page => params[:page])
  end
end
