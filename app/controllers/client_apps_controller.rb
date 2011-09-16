class ClientAppsController < ApplicationController
  before_filter :login_required
  load_and_authorize_resource
  
  def index
    
  end
  
  def new
    
  end
  
  def create
    
    if @client_app.save
      redirect_to client_apps_path, :notice => "Client application saved successfully!"
    else
      flash.now.alert = "There was a problem saving this application."
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
    if @client_app.update_attributes(params[:client_app])
      redirect_to client_apps_path, :notice => "Client application updated successfully!"
    else
      flash.now.alert = "There was a problem updating this application."
      render 'edit'
    end
  end
  
  def destroy
    
    @client_app.destroy
    redirect_to client_apps_path, :notice => "Client application deleted."
  end
end
