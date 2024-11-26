class TrainingPlansController < ApplicationController
  before_action :set_training_plan, only: [ :show ]

  def index
    @training_plans = policy_scope(TrainingPlan)
    authorize @training_plans
  end

  def show
    authorize @training_plan
  end

  private

  def set_training_plan
    @training_plan = TrainingPlan.find(params[:id])
  end

end
