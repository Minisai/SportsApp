class Coaches::AssessmentsController < ApplicationController
  def new
    @drills = Drill.all
  end

  def index
  end
end
