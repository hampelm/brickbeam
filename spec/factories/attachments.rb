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

FactoryGirl.define do
  factory :attachment do
    title "file title"
    source "file source"
  end

end
