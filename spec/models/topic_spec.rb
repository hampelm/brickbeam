# == Schema Information
#
# Table name: topics
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order       :integer
#

require 'rails_helper'

RSpec.describe Topic, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
