module ApplicationHelper
  include MessagingHelper

  def current_user_is_admin?
    controller.current_user_is_admin?
  end
  
  def truncate(s, n = 150)
    return s if s.length < n
    s[0, s.rindex(/\s/, n)] + ' ...'
  end

end
