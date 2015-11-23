class Site < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_many :projects
  belongs_to :user

  has_attached_file :photo, styles: { large: "1000x1000>", thumb: "100x100>" }
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  def generated_slug
    title
  end
end
