class Coaches::AssessmentsController < ApplicationController
  authorize_resource

  def new
    @drills = Drill.all
  end

  def index
    @assessments = current_user.role.assessments
  end

  def create
    assessment = current_user.role.assessments.create(assessment_params)
    if assessment.persisted?
      render :json => {:message => "Assessment was created successfully"}
    else
      render :json => {:message => assessment.errors.full_messages.join}, :status => :bad_request
    end
  end

  private
  def assessment_params
    params[:assessment].permit(:name, :description, :exercises_attributes => [:drill_id, :repetitions])
  end
end
