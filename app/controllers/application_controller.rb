class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :only_admins_on_staging! 

  before_action :configure_permitted_parameters, if: :devise_controller?


  helper_method :show_dev_features?

  protected

  # On the staging site, only admins can view pages. 
  def only_admins_on_staging!
    return unless Rails.configuration.is_staging
    return if request.env['PATH_INFO'] == new_user_session_path
    redirect_to new_user_session_path unless current_user.try(:is_admin?)
  end

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def protect_dev_features!
    return not_found unless show_dev_features?
  end

  def show_dev_features?
    (Rails.configuration.is_staging || Rails.env.development? || Rails.env.test?)
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
