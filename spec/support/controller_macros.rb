module ControllerMacros
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def it_requires_user_to_be_logged_in(*actions)
      actions.each do |action|
        it "#{action} should redirect user is not logged in" do
          get action, :id => 1
          response.should be_redirect
          response.should redirect_to root_url
        end
      end
    end
    
    def it_redirects_without_authoriztion(*actions)
      actions.each do |action|
        it "#{action} should redirect when not authorized" do
          logged_in
          get action, :id => 1
          response.should be_redirect
          response.should redirect_to users_path
        end
      end
    end
  end
  
  def with_cancan
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @controller.stub!(:current_ability).and_return(@ability)
  end
  
  def logged_in
    @current_user = mock_model User, :organization_id => 1, :admin? => false
    controller.stub!(:current_user).and_return(@current_user)
  end
  
  def not_logged_in
    controller.stub!(:current_user).and_return(false)
  end
end