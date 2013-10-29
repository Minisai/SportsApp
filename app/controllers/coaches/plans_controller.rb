class Coaches::PlansController < ApplicationController
  before_filter :load_coach
  authorize_resource

  def new
    @drills = Drill.all
    @rewards = @coach.rewards + Reward.default
    @assessments = @coach.assessments
  end

  def create
    plan = @coach.plans.create
    if plan.persisted?
      render :json => {:message => "Plan was created successfully"}
    else
      render :json => {:message => plan.errors.full_messages.join}, :status => :bad_request
    end
  end

  private
  def load_coach
    @coach = current_user.role
  end
end
