class PricingPlansController < ApplicationController
  def index
    if user_signed_in?
      @pricing_plans = PricingPlan.with_role_type_for(current_user)
    else
      @pricing_plans = PricingPlan.all
    end
  end
end
