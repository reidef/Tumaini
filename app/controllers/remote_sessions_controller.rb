class RemoteSessionsController < ApplicationController
  before_filter :login_required
  
  def create
    client_app_id = cookies[:client_token]
    client_app = current_user.client_apps.find_by_api_key(client_app_id)
    if client_app
      callback_url = client_app.callback_url + current_user.auth_token
      redirect_to callback_url
    else
      redirect_to current_user, :alert => "You are not authorized to use that application."
    end
  end
end
