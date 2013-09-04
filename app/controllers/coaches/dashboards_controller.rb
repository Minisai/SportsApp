class Coaches::DashboardsController < ApplicationController
  authorize_resource :class => false
  def show
    @team = current_user.role.teams.first
    @players = @team.players.paginate(:page => params[:page])
  end
end
