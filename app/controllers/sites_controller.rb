class SitesController < ApplicationController
  def show
    @site = Site.friendly.find(params[:id])
  end

  before_action :authenticate_user!
  def new
    @site = Site.new
  end

  before_action :authenticate_user!
  def create
    @site = Site.new(site_params)
    @site.user = current_user

    if @site.save
      redirect_to @site
    else
      render 'new'
    end
  end

  before_action :authenticate_user!
  def edit
    @site = Site.friendly.find(params[:id])

    unless user_owns_site?
      flash[:error] = "You do not have permissin to update this resource"
      redirect_to @site
      return
    end

    render 'edit'
  end

  before_action :authenticate_user!
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
      params.require(:site).permit(:title, :description)
    end

    def user_owns_site?
      @site.user == current_user
    end
end
