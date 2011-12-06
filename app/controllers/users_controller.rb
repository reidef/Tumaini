class UsersController < ApplicationController
  before_filter :login_required, :except => :authorize
  load_and_authorize_resource :except => [:new, :create, :authorize]
  
  def index
    @users_by_org = @users.where("organization_id IS NOT NULL").group_by(&:organization)
  end
  
  def new
    @organization = Organization.find(params[:organization_id]) if params[:organization_id]
    @user = @organization.users.build
    authorize! :new, @user
  end
  
  def create
    @organization = Organization.find(params[:organization_id]) if params[:organization_id]
    @user = @organization.users.build(params[:user])
    authorize! :create, @user
    if @user.save
      redirect_to organizations_path, :notice => "User created successfully."
    else
      flash.now.alert = "There was an error saving the user."
      render "new"
    end
  end
  
  def show
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
  
  def edit

  end
  
  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password_confirmation].blank?
    if @user.update_attributes(params[:user])
      redirect_to users_path, :notice => 'User updated successfully.'
    else
      flash.now.alert = 'There was an error updating this user.'
      render 'edit'
    end
  end
  
  def destroy
    @user.destroy
    redirect_to :back, :notice => 'User removed.'
  end
  
  def authorize
    @user = User.find_by_auth_token(params[:auth_token], :select => 'id, auth_token')
    respond_to do |format|
      if @user
        format.json { render json: @user }
      else
        format.json { render :text => "Forbidden: Invalid Token", :status => :unauthorized }
      end
    end
  end
end
