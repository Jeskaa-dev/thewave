class UserSkillsController < ApplicationController
  def index
    @user_skills = UserSkill.where(user_id: current_user.id)
    @skills = Skill.where(id: @user_skills.map(&:skill_id))
    authorize @user_skills
    @user = current_user
    @commit_status = @user.commit_status
    @top_user_skills = UserSkill.order(rating: :desc).limit(3)
    @bottom_user_skills = UserSkill.order(rating: :asc).limit(3)
  end
end
