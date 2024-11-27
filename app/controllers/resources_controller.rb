class ResourcesController < ApplicationController
  before_action :set_resource,  only: [ :show ]

  def index
    @resources = policy_scope(Resource)
    authorize @resources
  end

  def show
    authorize @resource
  end

  # def suggest_resources
  #   skill = Skill.find(params[:skill_id])
  #   proficiency = current_user.proficiency_in(skill)
  #   if proficiency <= 25
  #     @resources = Resource.where(skill: skill, difficulty: 'Débutant')
  #   elsif proficiency <= 50
  #     @resources = Resource.where(skill: skill, difficulty: 'Intermédiaire')
  #   else
  #     @resources = Resource.where(skill: skill, difficulty: ['Intermédiaire', 'Professionnel'])
  #   end
  #   render :index
  # end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end
end
