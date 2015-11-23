class SitesController < ApplicationController
  layout "sites"
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @sites = Site.all
  end

  def show
    @site = Site.friendly.find(params[:id])
  end

  def new
    @site = Site.new
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
      params.require(:site).permit(:title, :description, :building_type, :building_size, :lat, :lng)
    end

    def user_owns_site?
      @site.user == current_user
    end
end
