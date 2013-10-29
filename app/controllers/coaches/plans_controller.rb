class Coaches::PlansController < ApplicationController
  before_filter :load_coach
  authorize_resource

  def new
    @drills = Drill.all
    @reward = @coach.rewards + Reward.default
    @reward = @coach.assessments
  end

  private
  def load_coach
    @coach = current_user.role
  end
end
