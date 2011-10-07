require 'spec_helper'

describe RemoteSessionsController do
  it_requires_user_to_be_logged_in :create
  
  before(:each) do
    @app = mock_model ClientApp, :callback_url => "http://example.com/"
    @current_user = mock_model User, :auth_token => "secret", :client_apps => @app
    controller.stub!(:current_user).and_return(@current_user)
    request.cookies[:client_token] = "token"
  end
  
  describe "GET 'create'" do
    it "redirects to the client app if user is authorized to access it" do
      @app.should_receive(:find_by_api_key).with("token").and_return(@app)
      get 'create'
      response.should redirect_to "http://example.com/secret"
    end
    
    it "redirects to the user's page with message if user is not authorized" do
      @app.should_receive(:find_by_api_key).with("token").and_return(nil)
      get 'create'
      response.should redirect_to @current_user
    end
  end

end
