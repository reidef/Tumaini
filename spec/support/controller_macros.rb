module ControllerMacros
  def logged_in
    @current_user = mock_model User
    controller.stub!(:current_user).and_return(@current_user)
  end
  
  def not_logged_in
    controller.stub!(:current_user).and_return(false)
  end
end