# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

class Page < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  def generated_slug
    title
  end
end
