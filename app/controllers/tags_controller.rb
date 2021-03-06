class TagsController < ApplicationController
  layout "tags"

  def index
    @interior = Resource.tagged_with("Interior")
    @exterior = Resource.tagged_with("Exterior")
  end

  def show
    @topics = Topic.all()
    @tags = ActsAsTaggableOn::Tag.all.sort_by { |obj| obj.name.downcase }

    @tag = params[:id]
    @resources = Resource.tagged_with(params[:id])
    @events = Event.tagged_with(params[:id]).reverse_order
    @questions = Question.tagged_with(params[:id])
    @projects = Project.tagged_with(params[:id])
    @contractors = Contractor.approved.tagged_with(params[:id])
  end

end
