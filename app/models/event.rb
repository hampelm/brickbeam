class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  acts_as_taggable

  belongs_to:user

  def generated_slug
    title
  end
end
