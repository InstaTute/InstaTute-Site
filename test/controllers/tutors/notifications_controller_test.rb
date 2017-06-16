require 'test_helper'

class Tutors::NotificationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get tutors_notifications_index_url
    assert_response :success
  end

end
