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

class Event < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  acts_as_taggable

  belongs_to :user

  default_scope { order(start_date: :asc) }
  scope :partner, -> { where(partner_event: :true) }
  scope :bbd, -> { where(partner_event: false) }
  scope :future, -> { where('end_date >= ?', Time.now) }
  scope :past, -> { where('end_date < ?', Time.now).order(start_date: :desc) }

  has_attached_file :photo,
    source_file_options: { all:     '-auto-orient' },
    styles: { larger: "2000x2000>",
              large: "1000x1000>",
              thumb: "500x500>" },
    convert_options: {
      larger: '-quality 85 -strip',
      large: '-quality 85 -strip',
      thumb: '-quality 85 -strip'
    }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/


  def generated_slug
    title
  end
end
