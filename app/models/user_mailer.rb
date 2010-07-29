class UserMailer < MailerBase

  def signup_notification(user)
    setup_email(user)
    @subject    += 'Please activate your new account'
    @body[:activation_code] = user.activation_code  
  end

  def activation(user)
    setup_email(user)
    @subject += 'Your account has been activated!'
  end

  def reset_notification(user)
    setup_email(user)
    @subject += 'Link to reset your password'
  end

end
