class EventsController < ApplicationController
  layout "events"

  def index
    @events = Event.where('end_date >= ?', Time.now).order('end_date DESC')
    @past_events = Event.where('end_date < ?', Time.now).order('end_date DESC')
  end

  def show
    @event = Event.friendly.find(params[:id])
  end
end
