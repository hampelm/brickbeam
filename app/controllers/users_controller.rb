# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  name                   :string
#  is_admin               :boolean
#  is_inactive            :boolean
#  agreement              :boolean
#  provider               :string
#  uid                    :string
#

class UsersController < ApplicationController
  layout "users"

  def show
    @user = User.find(params[:id])

    @subscriptions = Subscription.where user: @user.id
    @questions = Question.where user: @user.id
    @sites = Site.where user: @user.id
  end
end
