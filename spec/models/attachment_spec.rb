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

require 'rails_helper'

RSpec.describe Attachment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
