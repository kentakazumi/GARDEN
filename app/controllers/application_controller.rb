class ApplicationController < ActionController::Base
  protect_from_forgery

  before_action :configure_permitted_parameters, if: :devise_controller?
  def set_current_user
    @current_user=User.find_by(id :session[:user_id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  def after_sign_in_path_for(resource)
    user_path(resource)
  end

  def after_inactive_sign_in_path_for(resource)
    user_spath(resource)
  end

end
