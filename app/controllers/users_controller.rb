class UsersController < ApplicationController
  layout "users"

  def show
    @user = User.find(params[:id])

    @questions = Question.where(user: @user.id)
    @sites = Site.where(user: @user.id)

  end
end
