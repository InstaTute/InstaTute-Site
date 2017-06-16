# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/user_mailer/reg_session_notification
  def reg_session_notification
    UserMailer.reg_session_notification(Tutor.first, User.first, Session)
  end

end
