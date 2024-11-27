class ResourcesController < ApplicationController
  def index
    @resources = Resource.all
    authorize @resource
  end
end
