# == Schema Information
#
# Table name: subscriptions
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#  question_id :integer
#

FactoryBot.define do
  factory :subscription do
    
  end

end
