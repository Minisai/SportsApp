class Coaches::DashboardsController < ApplicationController
  authorize_resource :class => false
  def show
    @teams = current_user.role.teams.paginate(:page => params[:page])
    @team = @teams.first
    @players = @team.players.paginate(:page => params[:players_page]) if @team.present?
  end
end
