class ClientAppsController < ApplicationController
  def index
    @apps = ClientApp.all
  end
  
  def new
    @app = ClientApp.new
  end
  
  def create
    @app = ClientApp.new(params[:client_app])
    if @app.save
      redirect_to client_apps_path, :notice => "Client application saved successfully!"
    else
      flash.now.alert = "There was a problem saving this application."
      render 'new'
    end
  end
  
  def edit
    @app = ClientApp.find(params[:id])
  end
  
  def update
    @app = ClientApp.find(params[:id])
    if @app.update_attributes(params[:client_app])
      redirect_to client_apps_path, :notice => "Client application updated successfully!"
    else
      flash.now.alert = "There was a problem updating this application."
      render 'edit'
    end
  end
  
  def destroy
    @app = ClientApp.find(params[:id])
    @app.destroy
    redirect_to client_apps_path, :notice => "Client application deleted."
  end
end
