# == Schema Information
#
# Table name: questions
#
#  id          :integer          not null, primary key
#  title       :string
#  description :text
#  slug        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  hidden      :boolean
#

FactoryGirl.define do
  factory :question do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.paragraph }
    user

    trait :old do
      created_at 10.days.ago
      updated_at 10.days.ago
    end

    trait :locked do
      locked true
    end

    factory :question_with_hidden_comment do
      after(:create) do |question, evaluator|
        create(:comment, :hidden, question: question)
      end
    end
  end
end
