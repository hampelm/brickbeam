# == Schema Information
#
# Table name: attachments
#
#  id         :integer          not null, primary key
#  title      :string
#  source     :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Attachment < ActiveRecord::Base
  validates :title, presence: true

  has_attached_file :file_attachment
  belongs_to :resource
end
