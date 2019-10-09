# == Schema Information
#
# Table name: events
#
#  id                 :integer          not null, primary key
#  title              :string
#  description        :text
#  start_date         :datetime
#  end_date           :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#  user_id            :integer
#  location           :string
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#  partner_event      :boolean
#

class EventsController < ApplicationController
  layout "events"

  def index
    @events = Event.bbd.future
    @partner_events = Event.partner.future
    @past_events = Event.bbd.past
  end

  def show
    @event = Event.friendly.find(params[:id])
    @related = Event.tagged_with(@event.tags, :any => true).where.not(id: @event.id).limit(3)
  end
end
