class ResourcesController < ApplicationController
  layout "resources"

  def index
    @interior = Resource.tagged_with("Interior")
    @exterior = Resource.tagged_with("Exterior")
    @redtape = Resource.tagged_with("Red Tape")
  end

  def show
    @resource = Resource.friendly.find(params[:id])
  end

end
