class SkillsController < ApplicationController
  def index
    @skills = Skill.all
    authorize @skill
  end

  def create
    @skill = Skill.new(skill_params)
    authorize @skill
    if @skill.save
      redirect_to skills_path
    else
      render :new
    end
  end

  def new
    @skill = Skill.new
    authorize @skill
  end
end
