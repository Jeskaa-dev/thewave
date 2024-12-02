class UserSkillsController < ApplicationController
  def index
    @user_skills = UserSkill.where(user_id: current_user.id)
    @skills = Skill.where(id: @user_skills.map(&:skill_id))
    authorize @user_skill
  end
end
