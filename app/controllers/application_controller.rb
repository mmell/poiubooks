class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem

  filter_parameter_logging :password
  
  include Messaging
  
  def require_admin
    unless current_user and current_user.is_admin?
      error_message("Please sign on as an admin.")
      redirect_to(root_url) and return false
    end
    true
  end
  
  def require_user
    unless current_user
      error_message("Please sign on or create an account.")
      redirect_to(root_url) and return false
    end
    true
  end

end
