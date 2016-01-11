class WelcomeController < ApplicationController
  def index
    @resources = Resource.all.order('updated_at DESC').limit(8)
    @events = Event.where('end_date > ?', Time.now)
    @questions = Question.where(hidden: [false, nil]).order('created_at DESC').limit(4)
    @sites = Site.where(hidden: [false, nil]).all
  end
end
