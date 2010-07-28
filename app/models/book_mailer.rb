class BookMailer < MailerBase

  def book_notification(user, book)
    setup_email(user)
    @subject += "#{book.title} has been updated!"
    @body[:book] = book
  end

  def chapter_notification(user, chapter)
    setup_email(user)
    @subject += "#{chapter.book.title}: #{chapter.title} has been created or updated!"
    @body[:book] = chapter.book
    @body[:chapter] = chapter
  end

  def book_comment_notification(book, comment)
    setup_email(book.owner)
    @subject += "#{book.title} has new comment!"
    @body[:book] = book
    @body[:comment] = comment
  end

  def chapter_comment_notification(book, comment)
    setup_email(book.owner)
    @subject += "#{book.title}: #{comment.commentable.title} has new comment!"
    @body[:book] = book
    @body[:chapter] = comment.commentable
    @body[:comment] = comment
  end

  def notification_footer()
    %Q/
  We sent you this message because you requested that you be notified of these changes. You may manage your notifications here:
  	#{link_to("Notifications for #{h @user.full_name}", user_notifications_url(@user, :only_path => false, :host => SiteDomain ) )}.
/  
  end
  
end
