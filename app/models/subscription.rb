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

class Subscription < ActiveRecord::Base
    belongs_to :question
    belongs_to :user

    def self.new_subscription_for(user, question)
      # Don't create a subscription twice.
      subscription = Subscription.find_by question: question, user: user
      logger.debug "-----subscription----"
      logger.debug subscription
      if !subscription
        subscription = self.create(question: question, user: user)
      end
      return subscription
    end
end
