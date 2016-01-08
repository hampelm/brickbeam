class PagesController < ApplicationController
  layout "pages"

  def show
    @page = Page.friendly.find(params[:id])
  end
end
