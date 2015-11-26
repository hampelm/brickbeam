# == Schema Information
#
# Table name: resources
#
#  id         :integer          not null, primary key
#  title      :string
#  byline     :string
#  text       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Resource < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_many :attachments

  acts_as_taggable

  def generated_slug
    title
  end
end
