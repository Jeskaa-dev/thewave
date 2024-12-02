class ResourcesController < ApplicationController
  before_action :set_resource, only: [:show, :update, :destroy, :complete]

  def show
    render partial: 'resource_details', locals: { resource: @resource }
  end

  def complete
    completion = @resource.completions.find_or_initialize_by(user: current_user)
    completion.update(done: true)
    head :ok
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end
end
