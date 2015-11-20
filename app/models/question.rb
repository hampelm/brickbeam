class Question < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  acts_as_taggable

  has_many :comments
  belongs_to :user

  def generated_slug
    title
  end

end
