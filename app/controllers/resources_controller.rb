class ResourcesController < ApplicationController
  layout "resources"

  def index
    @interior = Resource.tagged_with("Interior")
    @exterior = Resource.tagged_with("Exterior")
  end

  def show
    @resource = Resource.friendly.find(params[:id])
  end

end
