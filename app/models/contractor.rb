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

  def title 
    self.business_name || self.name
  end

  def slug_candidates
    [
      [:business_name, :name]
    ]
  end
end

