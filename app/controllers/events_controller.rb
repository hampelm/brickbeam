class EventsController < ApplicationController
  layout "events"

  def index
    @events = Event.where('end_date > ?', Time.now)
  end
end
