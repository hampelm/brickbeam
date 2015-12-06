class ResourcesController < ApplicationController
  layout "resources"

  def index
    @resources = Resource.all
    @topics = Topic.all()

    @tags = ActsAsTaggableOn::Tag.all
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
