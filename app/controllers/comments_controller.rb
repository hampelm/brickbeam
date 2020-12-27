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

class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  invisible_captcha only: [:create], honeypot: :title

  def create
    @question = Question.friendly.find(params[:question_id])
    @comment = @question.comments.create(comment_params)
    @comment.user = current_user
    @comment.save

    if params[:comment][:subscribe] == "1"
      Subscription.new_subscription_for(current_user, @comment.question)
    end
    email_subscribers(@comment)

    redirect_to question_path(@question)
  end

  private

    def email_subscribers(comment)
      subscriptions = Subscription.where question: comment.question

      subscriptions.each do |subscription|
        # Don't email users about their own comments.
        if comment.user != subscription.user
          begin
            NotificationMailer.new_comment_email(subscription.user, comment).deliver_later
          rescue
            # Silently handle new comment email fails
          end
        end
      end
    end

    def comment_params
      params.require(:comment).permit(:body, :subscribe)
    end
end
