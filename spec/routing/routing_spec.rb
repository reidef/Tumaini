require 'spec_helper'

describe "routing from remote apps" do
  it "routes remote_sessions/create/:client_token to remote_sessions#create for client app" do
    { :get => "/remote_sessions/create/app_token" }.should route_to(
      :controller => "remote_sessions",
      :action => "create",
      :client_token => "app_token")
  end
end

describe "user session control" do
  it "routes login to sessions#new" do
    { :get => "/login" }.should route_to(
      :controller => "sessions",
      :action => "new")
  end
  
  it "routes logout to sessions#destroy" do
    { :get => "/logout" }.should route_to(
      :controller => "sessions",
      :action => "destroy")
  end
end

describe "root path" do
  it "routes to sessions#new" do
    { :get => "/" }.should route_to(
      :controller => "sessions",
      :action => "new")
  end
end