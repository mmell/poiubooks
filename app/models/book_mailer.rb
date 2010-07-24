class BookMailer < MailerBase

  def book_notification(user, book, notification)
    setup_email(user)
    @subject += "#{book.title} has been updated!"
    @body[:book] = book
    @body[:notification] = notification
  end

  def chapter_notification(user, book, chapter, notification)
    setup_email(user)
    @subject += "#{book.title}: #{chapter.title} has been created or updated!"
    @body[:book] = book
    @body[:chapter] = chapter
    @body[:notification] = notification
  end

  def book_comment_notification(owner, book, comment)
    setup_email(owner)
    @subject += "#{book.title} has new comment!"
    @body[:book] = book
    @body[:comment] = comment
  end

  def chapter_comment_notification(owner, book, comment)
    setup_email(owner)
    @subject += "#{book.title}: #{comment.commentable.title} has new comment!"
    @body[:book] = book
    @body[:chapter] = comment.commentable
    @body[:comment] = comment
  end

  def notification_footer
    %Q/
  We sent you this message because you requested it. Manage your notifications here:
  	#{link_to(h "Notifications for #{@user.full_name}", user_notifications_url(@user, :only_path => false, :host => SiteDomain ) )}.
/  
  end
  
end
