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
#  photo_credit       :string
#

class Resource < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_many :attachments

  has_attached_file :photo,
    source_file_options: { all:     '-auto-orient' },
    styles: {
      original: "",
      large: "1000x1000>",
      thumb: "500x500#"
    },
    convert_options: {
      large: '-quality 85 -strip',
      thumb: '-quality 85 -strip'
    }

  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  acts_as_taggable

  def generated_slug
    title
  end
end
