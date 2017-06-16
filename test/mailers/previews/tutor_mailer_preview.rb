# Preview all emails at http://localhost:3000/rails/mailers/tutor_mailer
class TutorMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/tutor_mailer/reg_session_notification
  def reg_session_notification
    TutorMailer.reg_session_notification(Tutor.first)
  end

  # Preview this email at http://localhost:3000/rails/mailers/tutor_mailer/bonus_session_notification
  def bonus_session_notification
    TutorMailer.bonus_session_notification
  end

end
