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

class SubscriptionsController < ApplicationController
  before_action :authenticate_user!

  def destroy
    @subscription = Subscription.find(params[:id])

    unless user_owns_subscription?
      flash[:error] = "You do not have permission to update this question"
      redirect_to @subscription.question
      return
    end

    @subscription.destroy
    redirect_to @subscription.question
  end

  private

    def user_owns_subscription?
      @subscription.user == current_user
    end
end
