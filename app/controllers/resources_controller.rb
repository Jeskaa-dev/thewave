class ResourcesController < ApplicationController
  before_action :set_resource,  only: [ :show ]

  def index
    @resources = policy_scope(Resource)
    authorize @resources
  end

  def show
    authorize @resource
  end



  private

  def set_resource
    @resource = Resource.find(params[:id])
  end
end
