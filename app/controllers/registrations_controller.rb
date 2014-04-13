class RegistrationsController < Devise::RegistrationsController
  before_filter :update_sanitized_params, :except=>[]
  def update_sanitized_params
    printf("\n\n\n\n\n\n\nBLAHHHH\n\n\n\n\n\n\n");
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation)}
    devise_parameter_sanitizer.for(:account_update) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation, :current_password)}
    devise_parameter_sanitizer.for(:update) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation, :current_password)}
    devise_parameter_sanitizer.for(:create) {|u| u.permit(:firstName, :lastName, :email,:state, :password, :password_confirmation, :current_password)}
  end
  def create
    printf("\n\n\n\n\n\n\nCREATE\n\n\n\n\n\n\n");
  end
end
