class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :must_be_admin! 
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def must_be_admin!
    return unless Rails.configuration.is_staging 
    redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params| 
      user_params.permit(
        :name,
        :email, 
        :password, 
        :password_confirmation, 
        :current_password,
        :agreement,
        :contact_me,
        :daily_question_digest,
      )
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params| 
      user_params.permit(
        :name,
        :email, 
        :password, 
        :password_confirmation, 
        :current_password,
        :agreement,
        :contact_me,
        :daily_question_digest,
      )
    end
  end
end
