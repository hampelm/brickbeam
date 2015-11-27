# == Schema Information
#
# Table name: projects
#
#  id          :integer          not null, primary key
#  description :text
#  duration    :string
#  cost        :string
#  site_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#

class Project < ActiveRecord::Base
  acts_as_taggable

  belongs_to :site
  belongs_to :user
end
