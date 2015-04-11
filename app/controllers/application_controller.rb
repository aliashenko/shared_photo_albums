class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) <<
      [:name, :email, :password, :password_confirmation, :current_password, :avatar, :avatar_cache, :remove_avatar, :remote_avatar_url]
    devise_parameter_sanitizer.for(:sign_in) <<
      [:name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.for(:sign_up) <<
      [:email, :password, :password_confirmation, :remember_me, :album_id]
  end
end
