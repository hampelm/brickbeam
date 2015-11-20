class QuestionsController < ApplicationController
  layout "questions"
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @questions = Question.all
  end

  def show
    @question = Question.friendly.find(params[:id])
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def edit
    @question = Question.friendly.find(params[:id])

    unless user_owns_question?
      flash[:error] = "You do not have permission to update this question"
      redirect_to @question
      return
    end

    render 'edit'
  end

  def update
    @question = Question.friendly.find(params[:id])

    unless user_owns_site?
      flash[:error] = "You do not have permission to update this question"
      redirect_to @question
      return
    end

    if @question.update(question_params)
      redirect_to @question
    else
      render 'edit'
    end
  end

  private
    def question_params
      params.require(:question).permit(:title, :description)
    end

    def user_owns_question?
      @question.user == current_user
    end
end
