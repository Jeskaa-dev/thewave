class UsersController < ApplicationController
  # Rescue from Pundit::NotAuthorizedError at the class level
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def show
    @training_plan = TrainingPlan.where(user_id: current_user.id).first
    @completions = Completion.where(training_plan_id: @training_plan.id)
    @skills = Skill.where(user_skill: current_user.id)

    @user = policy_scope(User).find(params[:id])
    authorize @user
    @average_proficiency = current_user.average_proficiency
    # @commit_status = @user.user_commits
  end

  private

  def user_not_authorized
    redirect_to new_user_registration_path, alert: "You are not authorized to perform this action."
  end
end
