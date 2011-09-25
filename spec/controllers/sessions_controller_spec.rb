require 'spec_helper'

describe SessionsController do

  describe "GET 'new'" do
    it "should be successful" do
      get 'new'
      response.should be_success
    end
    
    it "should redirect to logged in user's page" do
      current_user = mock_model User
      controller.stub!(:current_user).and_return(current_user)
      get 'new'
      response.should redirect_to current_user
    end
  end

  describe "GET 'create'" do
    it "should redirect to user who just logged in" do
      user = mock_model User, :auth_token => "token"
      User.should_receive(:find_by_email).and_return(user)
      user.should_receive(:authenticate).and_return(user)
      get 'create'
      response.should redirect_to user
      flash[:notice].should eq("Logged in!")
    end
    
    it "should render 'new' template if login unsuccessful" do
      user = mock_model User, :auth_token => "token"
      User.should_receive(:find_by_email).and_return(user)
      user.should_receive(:authenticate).and_return(false)
      get 'create'
      response.should render_template 'new'
      flash[:alert].should eq("Invalid email or password")
    end
    
    it "should redirect to remote_sessions 'create' if client_token is set" do
      user = mock_model User, :auth_token => "token"
      User.should_receive(:find_by_email).and_return(user)
      user.should_receive(:authenticate).and_return(user)
      request.cookies[:client_token] = "token"
      get 'create'
      response.should redirect_to remote_sessions_path
    end
  end

  describe "GET 'destroy'" do
    it "should be successful" do
      get 'destroy'
      response.should redirect_to root_url
      flash[:notice].should eq("Logged out!")
    end
  end
end
