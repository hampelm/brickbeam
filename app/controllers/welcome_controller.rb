class WelcomeController < ApplicationController
  def index
    @resources = Resource.all.order('updated_at ASC').limit(8)
    @events = Event.bbd.future
    @questions = Question.where(hidden: [false, nil]).order('created_at DESC').limit(4)
    @sites = Site.where(hidden: [false, nil]).all

    @site_json = @sites.to_json({:include => {
      :projects => {
        :include => :tags
      }
    }})
  end
end
