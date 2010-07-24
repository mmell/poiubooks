class MailerBase < ActionMailer::Base

  protected
  def setup_email(user)
    @recipients  = "#{user.email}"
    @from        = "#{AdminEmail}"
    @subject     = "[#{SiteName}] "
    @sent_on     = Time.now
    @body[:user] = @user = user
  end
  
end
