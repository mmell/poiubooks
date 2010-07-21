module ControllerHelpers
  include AuthenticatedSystem

  def make_user_session(user = User.make)
    controller.stub!(:current_user).and_return(user)
    user
  end
  
  def make_admin_user_session(user = User.make(:is_admin => true))
    controller.stub!(:current_user).and_return(user)
    user
  end

end
