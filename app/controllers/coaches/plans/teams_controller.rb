class Coaches::Plans::TeamsController < ApplicationController
  authorize_resource
  before_filter :load_coach
  before_filter :load_plan

  def create
    if @plan.teams << @coach.teams.find(params[:team_id])
      render :json => @coach.teams, :each_serializer => TeamWithPlansSerializer
    end
  end

  def destroy
    if @plan.teams.delete(@coach.teams.find(params[:id]))
      render :json => @coach.teams, :each_serializer => TeamWithPlansSerializer
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