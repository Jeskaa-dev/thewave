class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :complete]
  before_action :authenticate_user!

  def show
    render partial: 'resources/resource_details', locals: { resource: @resource }
  end

  def complete
    begin
      ActiveRecord::Base.transaction do
        training_plan = current_user.training_plans.first
        completion = @resource.completions.find_by(training_plan: training_plan)
        completion.done = true

        # Find or create UserSkill
        user_skill = current_user.user_skills.find_or_initialize_by(skill: @resource.skill)

        # Calculate and apply new rating
        increase = rating_increase_for_format(@resource.format)
        new_rating = [user_skill.rating + increase, 100].min
        user_skill.update!(rating: new_rating)

        if completion.save
          render json: {
            success: true,
            new_rating: new_rating
          }, status: :ok
        else
          render json: { error: completion.errors.full_messages }, status: :unprocessable_entity
        end
      end
    rescue => e
      Rails.logger.error "Error completing resource: #{e.message}"
      render json: { error: e.message }, status: :internal_server_error
    end
  end


  private

  def set_resource
    @resource = Resource.find(params[:id])
  end

  def rating_increase_for_format(format)
    case format
    when 'Vidéo'
      2
    when 'Exercice'
      5
    when 'Formation'
      10
    else
      0
    end
  end
end
