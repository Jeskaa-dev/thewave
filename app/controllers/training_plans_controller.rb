class TrainingPlansController < ApplicationController
  before_action :set_training_plan, only: %i[index show new edit update]

  def index
    authorize @training_plan
  end

  def show
    # @user = User.find(@training_plan.user_id)
    @skills = Skill.all
    @user_skills = current_user.user_skills
    # @completion = current_user.completions
    @resources = Resource.all
    authorize @training_plan
  end

  def new
  end

  def create
    @training_plan = TrainingPlan.new(training_plan_params)
    @training_plan.user = current_user
    authorize @training_plan
    if @training_plan.save
      redirect_to training_plan_path(@training_plan)
    else
      render :new
    end
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

  def training_plan_params
    params.require(:training_plan).permit(:id, :user_id, :skill_id, :name, :description)
  end
end
