# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  description :text
#  duration    :string
#  cost        :string
#  site_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class ProjectsController < ApplicationController
  def create
    @site = Site.friendly.find(params[:site_id])
    @project = @site.projects.create(project_params)
    redirect_to site_path(@site)
  end

  private
    def project_params
      params.require(:project).permit(:duration, :description, :cost, :tag_list)
    end
end
