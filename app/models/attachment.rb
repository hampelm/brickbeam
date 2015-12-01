# == Schema Information
#
# Table name: attachments
#
#  id                           :integer          not null, primary key
#  title                        :string
#  source                       :string
#  created_at                   :datetime         not null
#  updated_at                   :datetime         not null
#  file_attachment_file_name    :string
#  file_attachment_content_type :string
#  file_attachment_file_size    :integer
#  file_attachment_updated_at   :datetime
#  resource_id                  :integer
#

class Attachment < ActiveRecord::Base
  validates :title, presence: true

  has_attached_file :file_attachment
  belongs_to :resource
end
