class UserSkillsController < ApplicationController
  def index
    @user_skills = UserSkill.all
    authorize @user_skill
  end
end
