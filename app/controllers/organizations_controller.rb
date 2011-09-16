class OrganizationsController < ApplicationController
  before_filter :login_required
  load_and_authorize_resource
  
  def index
    
  end
  
  def new
    
  end
  
  def create
    
    if @organization.save
      redirect_to organizations_path, :notice => "Organization saved successfully!"
    else
      flash.now.alert = "There was a problem creating this organization."
      render 'new'
    end
  end
  
  def edit
    
  end
  
  def update
    
    if @organization.update_attributes(params[:organization])
      redirect_to organizations_path, :notice => "Organization updated successfully!"
    else
      flash.now.alert = "There was a problem updating this organization."
      render 'edit'
    end
  end
  
  def destroy
    
    @organization.destroy
    redirect_to organizations_path, :notice => "Organization and all associated users deleted."
  end
end
