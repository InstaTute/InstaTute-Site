class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.reg_session_notification.subject
  #
  def reg_session_notification(tutor,user,session)
    @tutor = tutor
    @user = user
    @session = session
    @notice = "Congratulations " + @user.first_name + ", you have successfully booked an in-person session with " + @tutor.first_name + " at " + @session.location + ". Course: " + Course.where(:id => @session.course_id).sample.name + ". Topic: " + @session.topic + "."
    @details = "Please be there on " + @session.start.strftime("%m/%d/%Y at %I:%M%p.") + "The session will last " + @session.length.to_s + " minutes."


    mail to: @user.email, subject: "You Have Booked A Session"
  end
end
