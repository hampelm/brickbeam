class WelcomeController < ApplicationController
  def index
    @resources = Resource.all
    @events = Event.where('end_date > ?', Time.now)
  end
end
