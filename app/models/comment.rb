# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  body        :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  hidden      :boolean
#

class Comment < ActiveRecord::Base
  attr_accessor :subscribe

  validates :body, presence: true

  default_scope { order('created_at ASC') }

  belongs_to :question
  belongs_to :user
end
