class Coaches::PlansController < ApplicationController
  def new
    @drills = Drill.all
  end
end
