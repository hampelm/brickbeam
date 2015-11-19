class ProjectsController < ApplicationController

  def create
    @site = Site.friendly.find(params[:site_id])
    @project = @site.projects.create(project_params)
    redirect_to site_path(@site)
  end

  private
    def project_params
      params.require(:project).permit(:duration, :description, :cost)
    end
end
