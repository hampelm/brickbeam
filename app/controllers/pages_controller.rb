# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class PagesController < ApplicationController
  layout "pages"

  def show
    @page = Page.friendly.find(params[:id])
  end
end
