require 'test_helper'

class TutorMailerTest < ActionMailer::TestCase
  test "reg_session_notification" do
    mail = TutorMailer.reg_session_notification
    assert_equal "Reg session notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "bonus_session_notification" do
    mail = TutorMailer.bonus_session_notification
    assert_equal "Bonus session notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
