class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def create
    @question = Question.friendly.find(params[:question_id])
    @comment = @question.comments.create(comment_params)
    @comment.user = current_user
    @comment.save

    if params[:subscribe] == true
      @subscription = @Subscription.create()
      @subscription.user = current_user
      @subscription.save()
    end

    NotificationMailer.new_comment_email(@question.user, @comment).deliver_later

    redirect_to question_path(@question)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
