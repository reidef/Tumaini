class UsersController < ApplicationController
  before_filter :login_required, :except => :authorize
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to users_path, :notice => "User created successfully."
    else
      flash.now.alert = "There was an error saving the user."
      render "new"
    end
  end
  
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html
      format.json { render json: @user }
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :notice => 'User removed.'
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
