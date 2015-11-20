class CommentsController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]

  def create
    @question = Question.friendly.find(params[:question_id])
    @comment = @question.comments.create(comment_params)
    @comment.user = current_user
    @comment.save

    redirect_to question_path(@question)
  end

  private
    def comment_params
      params.require(:comment).permit(:body)
    end
end
