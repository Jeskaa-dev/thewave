class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :complete]

  def show
    render partial: 'resources/resource_details', locals: { resource: @resource }
  end

  def complete
    begin
      completion = @resource.completions.find_or_initialize_by(user: current_user)
      if completion.update(done: true)
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
