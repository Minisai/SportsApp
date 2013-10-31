class Coaches::PlansController < ApplicationController
  before_filter :load_coach
  authorize_resource

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
end
