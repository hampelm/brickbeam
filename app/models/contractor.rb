# == Schema Information
#
# Table name: contractors
#
#  id                  :integer          not null, primary key
#  name                :string
#  business_name       :string
#  city                :string
#  address             :string
#  website             :string
#  phone               :string
#  email               :string
#  description         :text
#  slug                :string
#  approved            :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  blurb               :string
#  user_id             :integer
#  image1_file_name    :string
#  image1_content_type :string
#  image1_file_size    :integer
#  image1_updated_at   :datetime
#  image2_file_name    :string
#  image2_content_type :string
#  image2_file_size    :integer
#  image2_updated_at   :datetime
#  image3_file_name    :string
#  image3_content_type :string
#  image3_file_size    :integer
#  image3_updated_at   :datetime
#  caption1            :text
#  caption2            :text
#  caption3            :text
#

class Contractor < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  acts_as_taggable
  validate :has_a_name

  belongs_to :user

  # Image uploads
  image_styles = { large: "1000x1000>", medium: "600x800>", thumb: "100x100>" }
  image_content_type = /\Aimage\/.*\Z/
  has_attached_file :image1, styles: image_styles
  validates_attachment_content_type :image1, content_type: image_content_type
  has_attached_file :image2, styles: image_styles
  validates_attachment_content_type :image2, content_type: image_content_type
  has_attached_file :image3, styles: image_styles
  validates_attachment_content_type :image3, content_type: image_content_type


  default_scope { order updated_at: :desc }
  scope :approved, -> { where(approved: true) }

  def tag_classes
    self.tags.map { |tag| 'tag-' + tag.id.to_s}.join(' ')
  end

  def is_detroit
    self.city.downcase == 'detroit'
  end

  def featured?
    'featured' if self.is_detroit
  end

  def title 
    if self.business_name? 
      self.business_name
    else
      self.name
    end
  end

  def has_a_name
    unless [name?, business_name?].include?(true)
      errors.add :base, 'Please add a name or business name'
    end
  end 

  def slug_candidates
    [
      [:business_name, :name]
    ]
  end
end

