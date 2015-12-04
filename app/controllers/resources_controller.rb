class ResourcesController < ApplicationController
  layout "resources"

  def index
    @interior = Resource.tagged_with("Interior")
    @exterior = Resource.tagged_with("Exterior")
    @redtape = Resource.tagged_with("Red Tape")
  end

  def show
    @resource = Resource.friendly.find(params[:id])
    @topics = Topic.all()
    @related = Resource.tagged_with(@resource.tags, :any => true)

    @related_by_tag = Hash.new []
    @related.each do |related|
      related.tags.each do |tag|
        @related_by_tag[tag] += [related]
      end
    end

  end

end
