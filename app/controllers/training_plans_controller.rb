class TrainingPlansController < ApplicationController
  before_action :set_training_plan, only: %i[edit update]

  def show
    @training_plan = TrainingPlan.find(params[:id])
    authorize @training_plan
  end

  def edit
    authorize @training_plan
  end

  def update
    authorize @training_plan
    if @training_plan.update(training_plan_params)
      redirect_to training_plan_path(@training_plan)
    else
      render :edit
    end
  end

  private

  def user_not_authorized
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end

  def set_training_plan
    @training_plan = TrainingPlan.find(params[:id])
  end
end
