class SessionsController < ApplicationController
  def new
    redirect_to current_user if logged_in?
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      if cookies[:client_token]
        redirect_to "/remote_sessions/create"
      else
        redirect_to user, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    if logged_in?
      current_user.generate_token(:auth_token) # generate a new token to log out of all sites
      current_user.save
    end
    cookies.delete(:auth_token)
    redirect_to root_url, :notice => "Logged out!"
  end

end
