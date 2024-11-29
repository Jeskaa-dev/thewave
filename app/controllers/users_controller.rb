class UsersController < ApplicationController
  # Rescue from Pundit::NotAuthorizedError at the class level
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  def show

    @user = policy_scope(User).find(params[:id])
    @skills = Skill.all
    @user_skills = UserSkill.all
    authorize @user
  end

  private

  def user_not_authorized
    redirect_to root_path, alert: "You are not authorized to perform this action."
  end
end
