class Resource < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  attr_accessible :title, :body, :tag_list
  acts_as_taggable


  def generated_slug
    title
  end
end
