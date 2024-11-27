class TrainingPlansController < ApplicationController
  before_action :set_training_plan, only: %i[show edit update]

  def show
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

  def set_training_plan
    @training_plan = TrainingPlan.find(params[:id])
  end
end
