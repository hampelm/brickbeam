class TagsController < ApplicationController
  layout "tags"

  def index
    @interior = Resource.tagged_with("Interior")
    @exterior = Resource.tagged_with("Exterior")
  end

  def show
    @tag = params[:id]
    @resources = Resource.tagged_with(params[:id])
    @events = Event.tagged_with(params[:id])
    @questions = Question.tagged_with(params[:id])
    @projects = Project.tagged_with(params[:id])
  end

end
