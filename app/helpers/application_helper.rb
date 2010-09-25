module ApplicationHelper
  include MessagingHelper

  def current_user_is_admin?
    controller.current_user_is_admin?
  end
  
  def truncate(s, n = 150)
    return s # truncating in the middle of a tag element, e.g. <p>, makes problems
    return s if s.length < n
    sanitize(s[0, s.rindex(/\s/, n)] + ' ...')
  end

  def display_user_content(s)
    sanitize( s, 
      :tags => %w(p strong em span ul ol li blockquote a 
        img object param
        table tr td), 
      :attributes => %w(href name src width height alt style
        data type value
      ) 
    )
  end
  
end
