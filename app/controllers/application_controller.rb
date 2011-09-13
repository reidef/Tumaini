class ApplicationController < ActionController::Base
  protect_from_forgery
  
  private
  def current_user
    @current_user ||= User.find_by_auth_token(cookies[:auth_token]) if cookies[:auth_token]
  end
  
  def logged_in?
    current_user
  end

  def login_required
    cookies[:client_token] = params[:client_token] if params[:client_token]
    unless logged_in?
      redirect_to root_url, :alert => "You must be logged in to access that page."
    end
  end
  
  helper_method :current_user
end
