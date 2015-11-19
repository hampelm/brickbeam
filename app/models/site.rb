class Site < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_many :projects
  belongs_to :user

  def generated_slug
    title
  end
end
