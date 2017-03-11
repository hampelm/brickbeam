# == Schema Information
#
# Table name: contractors
#
#  id            :integer          not null, primary key
#  name          :string
#  business_name :string
#  city          :string
#  address       :string
#  website       :string
#  phone         :string
#  email         :string
#  description   :text
#  slug          :string
#  approved      :boolean
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Contractor < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slug_candidates, :use => :slugged

  acts_as_taggable
  validate :has_a_name

  belongs_to :user

  default_scope { order updated_at: :desc }
  scope :approved, -> { where(approved: true) }

  def tag_classes
    self.tags.map { |tag| tag.id }.join('tag-')
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

