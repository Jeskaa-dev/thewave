class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :complete]
  before_action :authenticate_user!

  def show
    render partial: 'resources/resource_details', locals: { resource: @resource }
  end

  def complete
    begin
      training_plan = current_user.training_plans.first
      completion = @resource.completions.find_by(training_plan: training_plan)
      completion.done = true
      if completion.save
        render json: { success: true }, status: :ok
      else
        render json: { error: completion.errors.full_messages }, status: :unprocessable_entity
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
end
