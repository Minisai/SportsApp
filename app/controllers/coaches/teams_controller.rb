class Coaches::TeamsController < ApplicationController
  def index
    @players = current_user.role.players
    @teams = current_user.role.teams
  end
end
