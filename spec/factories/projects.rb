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

FactoryBot.define do
  factory :project do
    description { FFaker::Lorem.paragraph }
    site
  end
end
