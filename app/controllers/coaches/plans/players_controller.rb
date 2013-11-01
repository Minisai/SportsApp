class Coaches::Plans::PlayersController < ApplicationController
  authorize_resource
  before_filter :load_coach
  before_filter :load_plan

  def create
    if @plan.players << @coach.players.find(params[:player_id])
      render :json => @coach.players, :each_serializer => PlayerWithPlansSerializer
    end
  end

  def destroy
    if @plan.players.delete(@coach.players.find(params[:id]))
      render :json => @coach.players, :each_serializer => PlayerWithPlansSerializer
    end
  end

  private
  def load_coach
    @coach = current_user.role
  end

  def load_plan
    @plan = Plan.default_or_for_coach(@coach).find(params[:plan_id])
  end
end