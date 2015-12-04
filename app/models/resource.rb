# == Schema Information
#
# Table name: resources
#
#  id                 :integer          not null, primary key
#  title              :string
#  byline             :string
#  text               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  slug               :string
#  photo_file_name    :string
#  photo_content_type :string
#  photo_file_size    :integer
#  photo_updated_at   :datetime
#

class Resource < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_many :attachments

  has_attached_file :photo, styles: { large: "1000x1000>", thumb: "300x300#" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  acts_as_taggable

  def generated_slug
    title
  end
end
