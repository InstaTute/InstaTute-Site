class TutorMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tutor_mailer.reg_session_notification.subject
  #
  def reg_session_notification(tutor,user,session)
    @tutor = tutor
    @user = user
    @session = session
    @notice = @user.first_name + " has booked you for an in-person session at " + @session.location + ". Course: " + Course.find(@session.course_id).name + ". Topic: " + @session.topic + ". "
    @details = "Please be there on " + @session.start.strftime("%m/%d/%Y at %I:%M%p.") + "The session will last " + @session.length.to_s + " minutes."


    mail to: @tutor.email, subject: "You Have Been Booked For A Session"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.tutor_mailer.bonus_session_notification.subject
  #

end
