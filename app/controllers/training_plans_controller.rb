class TrainingPlansController < ApplicationController
  before_action :set_training_plan, only: %i[index show done]

  def index
    authorize @training_plan
  end

  def show
    @user_skills = current_user.user_skills
    @full_skills = Skill.all
    @completions = Completion.where(training_plan_id: @training_plan.id)
    @resources = Resource.where(id: @completions.map(&:resource_id))
    @skills = Skill.where(id: @user_skills.map(&:skill_id))
    authorize @training_plan
  end

  # def edit
  #   authorize @training_plan
  # end

  # def update
  #   authorize @training_plan
  #   if @training_plan.update(training_plan_params)
  #     redirect_to training_plan_path(@training_plan)
  #   else
  #     render :edit
  #   end
  # end

  def done
    @completions = Completion.where(training_plan_id: @training_plan.id)
    authorize @completion
  end

  private

  def user_not_authorized
    redirect_to new_user_registration_path, alert: "You are not authorized to perform this action."
  end

  def set_training_plan
    @training_plan = TrainingPlan.find(params[:id])
  end

  def training_plan_params
    params.require(:training_plan).permit(:id, :user_id, :skill_id)
  end
end
