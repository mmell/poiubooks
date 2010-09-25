class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  include AuthenticatedSystem

  before_filter :session_return_to, :config_layout

  filter_parameter_logging :password
  
  include Messaging
  
  def current_user_is_admin?
    current_user and current_user.is_admin?
  end
  
  def require_admin
    unless current_user_is_admin?
      error_message("Please Sign In as an admin.")
      redirect_to(root_url) and return false
    end
    true
  end
  
  def require_user
    unless current_user
      error_message("Please Sign In or create an account.")
      redirect_to(new_user_url) and return false
    end
    true
  end
  
protected
  def session_return_to
    session[:return_to] = url_for if !logged_in? and !['sessions', 'users'].include?(controller_name)
  end
  
  def config_layout
    @content_row = 'layouts/content_rows/default'
  end
  
  def use_tinymce(mode = :ignored)
    @application_javascripts = ['tiny_mce/tiny_mce.js']
    @application_javascripts << 'tiny_mce_init.js'
    return
    
    case mode
    when :full
      @application_javascripts << 'tiny_mce_init.js'
    when :simple
      @application_javascripts << 'tiny_mce_init_simple.js'
    end

  end
  
end
