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

  attr_accessor :subscribe

  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  belongs_to :user

  validates :title, presence: true, length: { maximum: 175, too_long: "Your question is too long to fit (the maximim is 175 characters). You can put as much additional information as you need into the details section below." }

  def generated_slug
    title
  end
end
