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
#

class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  acts_as_taggable

  belongs_to:user

  default_scope { order('end_date DESC') }

  has_attached_file :photo,
    source_file_options: { all:     '-auto-orient' },
    styles: { large: "1000x1000>",
              thumb: "300x300>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/


  def generated_slug
    title
  end
end
