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

class Topic < ActiveRecord::Base
  acts_as_taggable

  default_scope { order('"order" ASC') }
end
