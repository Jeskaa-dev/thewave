class ResourcesController < ApplicationController
  before_action :set_resource,  only: [ :show ]

  def index
    @resources = Resource.all
  end

  def show
  end

  private

  def set_resource
    @resource = Resource.find(params[:id])
  end
end
