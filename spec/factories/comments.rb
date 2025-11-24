# == Schema Information
#
# Table name: comments
#
#  id          :integer          not null, primary key
#  body        :text
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  hidden      :boolean
#

FactoryBot.define do
  factory :comment do
    body { FFaker::Lorem.paragraph }
    question

    trait :hidden do
      hidden { true }
    end
  end
end
