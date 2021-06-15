class ApplicationController < ActionController::API
  # protect_from_forgery with: :exception
  # helper_method :current_user
  # before_action :authorized

  # def current_user
  #   @current_user ||= User.find(session[:user_id]) if session[:user_id]
  # end

  # def authorized
  #   not_found unless current_user
  # end

  # def not_found
  #   render file: "#{Rails.root}/public/404.html", status: :not_found
  # end

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
