class ApplicationController < ActionController::Base
 before_action :configure_permitted_parameters, if: :devise_controller?
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation, :current_password)}
    devise_parameter_sanitizer.for(:update) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation, :current_password)}
    devise_parameter_sanitizer.for(:create) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation, :current_password)}
  end
end
