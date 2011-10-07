require 'spec_helper'

describe OrganizationsController do
  it_requires_user_to_be_logged_in :index, :new, :create, :edit, :update, :destroy
  describe "authoriztion" do
    before(:each) { Organization.stub(:find) }
    it_redirects_without_authoriztion :index, :new, :create, :edit, :update, :destroy
  end
  
  before :each do
    with_cancan
  end
  
  describe "when logged in" do
    before :each  do
      logged_in
    end
    
    describe "GET 'index'" do
      it "should render index when authorized" do
        @ability.can :read, Organization
        get 'index'
        response.should be_success
        response.should render_template "organizations/index"
      end
    end
    
    describe "get 'new'" do
      it "should render new when authorized" do
        @ability.can :create, Organization
        get 'new'
        response.should be_success
        response.should render_template "organizations/new"
      end
    end
    
    describe "get 'create'" do
      before :each do
        @org = mock_model Organization
      end
      
      it "should create user and redirect" do
        @ability.can :create, Organization
        Organization.should_receive(:new).and_return(@org)
        @org.should_receive(:save).and_return(true)
        get 'create'
        response.should be_redirect
        response.should redirect_to organizations_path
      end
    end
    
    describe "get 'edit'" do
      it "should render edit when authorized" do
        @ability.can :edit, Organization
        Organization.should_receive(:find).with("1").and_return(stub_model Organization)
        get 'edit', :id => 1
        response.should be_success
        response.should render_template "organizations/edit"
      end
    end
    
    describe "get 'update'" do
      before :each do
        @org = mock_model Organization
        Organization.should_receive(:find).with("1").and_return(@org)
      end
      describe "when authorized" do
        before :each do
          @ability.can :update, Organization
        end
        
        it "should update user and redirect" do
          @org.should_receive(:update_attributes).and_return(true)
          get 'update', :id => 1
          response.should be_redirect
          response.should redirect_to organizations_path
        end
        
        it "should render edit if update fails" do
          @org.should_receive(:update_attributes).and_return(false)
          get 'update', :id => 1
          response.should be_success
          response.should render_template "organizations/edit"
        end
      end
      
      it "when not authorized should redirect" do
        @ability.cannot :update, Organization
        get 'update', :id => 1
        response.should be_redirect
        response.should redirect_to users_path
      end
    end
    
    
  end
end
