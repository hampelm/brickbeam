# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  title      :string
#  body       :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  slug       :string
#

FactoryBot.define do
  factory :page do
    title { "MyString" }
    body { "MyText" }
  end

end
