class Coaches::PlansController < ApplicationController
  before_filter :load_coach
  before_filter :load_plans, :only => [:index, :assign]
  authorize_resource

  def index
  end

  def show
    @plan = Plan.default_or_for_coach(@coach).find(params[:id])
  end

  def new
    @drills = Drill.all
    @rewards = @coach.rewards + Reward.default
    @assessments = @coach.assessments
  end

  def create
    plan = @coach.plans.create(plan_params[:plan])
    if plan.persisted?
      plan.update_attributes(:plan_items_attributes => PlanItem.build_from(plan_params[:plan_items]))
      render :json => {:message => "Plan was created successfully"}
    else
      render :json => {:message => plan.errors.full_messages.join}, :status => :bad_request
    end
  end

  def assign
    @plans = @coach.plans
    @default_plans = Plan.default
    @teams = @coach.teams
    @players = @coach.players
  end

  private
  def plan_params
    params.permit(:plan => [:name, :description],
                  :plan_items => [:item_type, :id,
                                  :days_attributes => [:exercises_attributes => [:drill_id, :repetitions]]])
  end

  def load_coach
    @coach = current_user.role
  end

  def load_plans
    @plans = @coach.plans
    @default_plans = Plan.default
  end
end
