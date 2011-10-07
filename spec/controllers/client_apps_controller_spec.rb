require 'spec_helper'

describe ClientAppsController do
  it_requires_user_to_be_logged_in :index, :new, :create, :edit, :update, :destroy
  describe "user is not authorized" do
    before(:each) { ClientApp.stub(:find) }
    it_redirects_without_authoriztion :index, :new, :create, :edit, :update, :destroy
  end
  
  describe "when user is authorized," do
    before :each do
      logged_in
      with_cancan
    end
    
    describe "get 'index'" do
      it "should render index" do
        @ability.can :read, ClientApp
        get 'index'
        response.should be_success
        response.should render_template "client_apps/index"
      end
    end
    
    describe "get 'new'" do
      it "should render new" do
        @ability.can :new, ClientApp
        get 'new'
        response.should be_success
        response.should render_template "client_apps/new"
      end
    end
    
    describe "get 'create'" do
      before :each do
        @client_app = mock_model ClientApp
        @ability.can :create, ClientApp
        ClientApp.should_receive(:new).and_return(@client_app)
      end
      
      it "should should create client app and redirect" do
        @client_app.should_receive(:save).and_return(true)
        get 'create'
        response.should be_redirect
        response.should redirect_to client_apps_path
      end
      
      it "should should render new on failed save" do
        @client_app.should_receive(:save).and_return(false)
        get 'create'
        response.should be_success
        response.should render_template "client_apps/new"
      end
    end
    
    describe "get 'edit'" do
      before :each do
        @client_app = mock_model ClientApp
        @ability.can :edit, ClientApp
        ClientApp.should_receive(:find).with("1").and_return(@client_app)
      end
      
      it "should render edit" do
        get 'edit', :id => 1
        response.should be_success
        response.should render_template "client_apps/edit"
      end
    end
    
    describe "get 'update'" do
      before :each do
        @client_app = mock_model ClientApp
        @ability.can :update, ClientApp
        ClientApp.should_receive(:find).with("1").and_return(@client_app)
      end
      
      it "should should update client app and redirect" do
        @client_app.should_receive(:update_attributes).and_return(true)
        get 'update', :id => 1
        response.should be_redirect
        response.should redirect_to client_apps_path
      end
      
      it "should should render edit on failed save" do
        @client_app.should_receive(:update_attributes).and_return(false)
        get 'update', :id => 1
        response.should be_success
        response.should render_template "client_apps/edit"
      end
    end
    
    describe "get 'destroy'" do
      before :each do
        @client_app = mock_model ClientApp
        @ability.can :destroy, ClientApp
        ClientApp.should_receive(:find).with("1").and_return(@client_app)
      end      
      
      it "should redirect after destroy" do
        @client_app.should_receive(:destroy)
        get 'destroy', :id => 1
        response.should be_redirect
        response.should redirect_to client_apps_path
      end
    end
  end

end
