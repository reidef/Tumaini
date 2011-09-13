class RemoteSessionsController < ApplicationController
  before_filter :login_required
  
  def create
    # TODO Authorize client_key per user
    # redirect to app that made the requect
    callback_url = "http://mradi.dev/sessions/create/#{current_user.auth_token}"
    redirect_to callback_url
  end
end
