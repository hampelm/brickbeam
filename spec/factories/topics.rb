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

FactoryGirl.define do
  factory :topic do
    name "MyString"
    description "MyText"
  end

end
