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

class QuestionsController < ApplicationController
  layout "questions"
  before_action :authenticate_user!, :except => [:index, :show]

  autocomplete :tag, :name, :class_name => 'ActsAsTaggableOn::Tag' # <- New

  def index
    @questions = Question.where(hidden: [false, nil]).order('created_at DESC').all
  end

  def show
    @question = Question.friendly.find(params[:id])
    @comments = @question.comments.where(hidden: [false, nil])
    @subscription = Subscription.find_by question: @question, user: current_user

    @related = Question.tagged_with(@question.tags, :any => true)
                       .where.not(id: @question.id)
                       .limit(6)
                       .order('created_at DESC')
  end

  def new
    @question = Question.new
    @tags = ActsAsTaggableOn::Tag.all
    @tags_sorted = @tags.sort_by { |obj| obj.name.downcase }
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      # Subscribe the asker to notifications
      if params[:question][:subscribe] == "1"
        Subscription.new_subscription_for(current_user, @question)
      end

      redirect_to @question
    else
      @tags = ActsAsTaggableOn::Tag.all
      @tags_sorted = @tags.sort_by { |obj| obj.name.downcase }
      render 'new'
    end
  end

  def edit
    @question = Question.friendly.find(params[:id])
    @tags = ActsAsTaggableOn::Tag.all
    @tags_sorted = @tags.sort_by { |obj| obj.name.downcase }

    unless user_owns_question?
      flash[:error] = "You do not have permission to update this question"
      redirect_to @question
      return
    end

    render 'edit'
  end

  def update
    @question = Question.friendly.find(params[:id])

    unless user_owns_question?
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
      params.require(:question).permit(:title, :description, :tag_list, :subscribe)
    end

    def user_owns_question?
      @question.user == current_user
    end
end
