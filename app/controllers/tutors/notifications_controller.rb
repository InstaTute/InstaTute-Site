class Tutors::NotificationsController < ApplicationController
  before_action :authenticate_tutor!
  def index
    @tutor = current_tutor
    @tutor.chat_ready = true
    @tutor.save
    @notifications = Notification.where(:tutor_id => current_tutor.id).all.reverse
  end
end
