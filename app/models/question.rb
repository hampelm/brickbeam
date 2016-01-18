# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  hidden      :boolean
#

class Question < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title, :use => :slugged

  acts_as_taggable

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :user

  def generated_slug
    title
  end
end
