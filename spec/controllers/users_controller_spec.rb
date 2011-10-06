require 'spec_helper'

describe UsersController do
  before :each do
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub!(:current_ability).and_return(@ability)
    
    @org = stub_model Organization
    Organization.stub!(:find).and_return(@org)
  end
  
  describe "GET 'index'" do
    describe "when logged in" do
      before :each do
        logged_in
      end
      
      it "should render index when authorized" do
        @ability.can :read, User
        get 'index'
        response.should be_success
        response.should render_template("users/index")
      end
    end
  end
  
  describe "GET 'new'" do
    describe "when logged in" do
      before :each do
        logged_in
      end
      
      it "should render new when authorized" do
        @ability.can :create, User
        get 'new', :organization_id => 1
        response.should be_success
        response.should render_template("users/new")
      end
    
      it "should redirect when not authorized" do
        @ability.cannot :create, User
        get 'new', :organization_id => 1
        response.should be_redirect
        response.should redirect_to users_path
      end
    end
  end
  
  describe "GET 'create'" do
    describe "when logged in" do
      before :each do
        logged_in
      end
      
      describe "and authorized" do
        before :each do
          @ability.can :create, User
          @new_user = mock_model User
          @org.stub!(:users).and_return(@new_user)
          @new_user.should_receive(:build).and_return(@new_user)
        end
      
        it "should create user and redirect" do
          @new_user.should_receive(:save).and_return(true)
          get 'create', :organization_id => 1
          response.should be_redirect
          response.should redirect_to organizations_path
        end
      
        it "should render 'new' if save fails" do
          @new_user.should_receive(:save).and_return(false)
          get 'create', :organization_id => 1
          response.should be_success
          response.should render_template "users/new"
        end
      end
    end
  end
  
  describe "GET 'edit'" do
    describe "when logged in" do
      before :each do
        logged_in
        User.should_receive(:find).with("1").and_return(stub_model User)
      end
      
      it "should render edit when authorized" do
        @ability.can :update, User
        get 'edit', :id => 1
        response.should be_success
        response.should render_template("users/edit")
      end
    
      it "should redirect when not authorized" do
        @ability.cannot :update, User
        get 'edit', :id => 1
        response.should be_redirect
        response.should redirect_to users_path
      end
    end
  end
  
  describe "updating a user" do
    describe "when logged in" do
      before :each do
        logged_in
        @updated_user = stub_model User
        User.should_receive(:find).with("1").and_return(@updated_user)
      end
      
      describe "and authorized" do
        before :each do
          @ability.can :update, User
        end
        
        it "should update user and redirect" do
          @updated_user.should_receive(:update_attributes).and_return(true)
          get 'update', :id => 1, :user => {}
          response.should be_redirect
          response.should redirect_to users_path
        end
        
        it "should render edit if update fails" do
          @updated_user.should_receive(:update_attributes).and_return(false)
          get 'update', :id => 1, :user => {}
          response.should be_success
          response.should render_template "users/edit"
        end
      end
    
      it "and not authorized should redirect" do
        @ability.cannot :update, User
        get 'update', :id => 1
        response.should be_redirect
        response.should redirect_to users_path
      end
    end
  end
end
