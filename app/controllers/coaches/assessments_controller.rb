class Coaches::AssessmentsController < ApplicationController
  authorize_resource
  before_filter :load_coach
  before_filter :load_assessment, :only => [:update, :destroy]

  def show
    @assessment = Assessment.default_or_for_coach(@coach).find(params[:id])
  end

  def new
    @drills = Drill.all
  end

  def index
    @assessments = @coach.assessments
    @default_assessments = Assessment.default
  end

  def create
    assessment = @coach.assessments.create(create_assessment_params)
    if assessment.persisted?
      render :json => {:message => "Assessment was created successfully"}
    else
      render :json => {:message => assessment.errors.full_messages.join}, :status => :bad_request
    end
  end

  def update
    if @assessment.update_attributes(update_assessment_params)
      render :json => @coach.assessments
    else
      render :json => {:message => @assessment.errors.full_messages.join}, :status => :bad_request
    end
  end

  def destroy
    if @assessment.destroy
      render :json => @coach.assessments
    else
      render :json => {:message => @assessment.errors.full_messages.join}, :status => :bad_request
    end
  end

  private
  def create_assessment_params
    params[:assessment].permit(:name, :description, :exercises_attributes => [:drill_id, :repetitions])
  end

  def update_assessment_params
    params[:assessment].permit(:name, :description, :exercises_attributes => [:id, :repetitions])
  end

  def load_coach
    @coach = current_user.role
  end

  def load_assessment
    @assessment = @coach.assessments.find(params[:id])
  end
end
