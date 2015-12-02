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

    factory :question_with_hidden_comment do
      after(:create) do |question, evaluator|
        create(:comment, :hidden, question: question)
      end
    end
  end
end
