# == Schema Information
#
# Table name: sites
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :text
#  lat                :decimal(, )
#  lng                :decimal(, )
#  created            :datetime
#  edited             :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#  user_id            :integer
#  building_type      :string
#  building_size      :string
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  hidden             :boolean
#

class SitesController < ApplicationController
  layout "sites"
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @sites = Site.where(hidden: [false, nil])
  end

  def show
    @site = Site.friendly.find(params[:id])
  end

  def new
    @site = Site.new
    @site.projects.build
  end

  def create
    @site = Site.new(site_params)
    @site.user = current_user

    if @site.save
      redirect_to @site
    else
      render 'new'
    end
  end

  def edit
    @site = Site.friendly.find(params[:id])

    unless user_owns_site?
      flash[:error] = "You do not have permissin to update this resource"
      redirect_to @site
      return
    end

    render 'edit'
  end

  def update
    @site = Site.friendly.find(params[:id])

    unless user_owns_site?
      flash[:error] = "You do not have permissin to update this resource"
      redirect_to @site
      return
    end

    if @site.update(site_params)
      redirect_to @site
    else
      render 'edit'
    end
  end

  private
    def site_params
      params.require(:site).permit(:title, :description,
        :building_type, :building_size,
        :lat, :lng, :photo,
        projects_attributes: [:description, :duration, :cost])
    end

    def user_owns_site?
      @site.user == current_user
    end
end
