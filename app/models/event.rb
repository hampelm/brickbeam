# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  start_date  :datetime
#  end_date    :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  slug        :string
#  user_id     :integer
#  location    :string
#

class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  acts_as_taggable

  belongs_to:user

  def generated_slug
    title
  end
end
