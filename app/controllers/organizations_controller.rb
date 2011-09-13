class OrganizationsController < ApplicationController
  def index
    @orgs = Organization.all
  end
  
  def new
    @org = Organization.new
  end
  
  def create
    @org = Organization.new(params[:organization])
    if @org.save
      redirect_to organizations_path, :notice => "Organization saved successfully!"
    else
      flash.now.alert = "There was a problem creating this organization."
      render 'new'
    end
  end
  
  def edit
    @org = Organization.find(params[:id])
  end
  
  def update
    @org = Organization.find(params[:id])
    if @org.update_attributes(params[:organization])
      redirect_to organizations_path, :notice => "Organization updated successfully!"
    else
      flash.now.alert = "There was a problem updating this organization."
      render 'edit'
    end
  end
  
  def destroy
    @org = Organization.find(params[:id])
    @org.destroy
    redirect_to organizations_path, :notice => "Organization and all associated users deleted."
  end
end
