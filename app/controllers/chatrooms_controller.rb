class ChatroomsController < ApplicationController
  before_action :set_chatroom, only: [:show, :destroy]

  def destroy
    @chatroom.destroy
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'Your chat session has ended.' }
      format.json { head :no_content }
    end
  end

  def finished
    @room = current_person.chatroom
    @room.finished = params[:finished]
    @room.save!
    respond_to do |format|
      format.html { redirect_to @room, alert: 'Your chat session is ending.' }
      format.js { render "chatrooms" }
    end
  end

  def create
    @room = Chatroom.new
    course = Course.find_by(name: params[:course_name])
    @room.course_id = course.id
    @room.topic = params[:topic]

    x = []

    if course.tutors.length > 0
      course.tutors.each do |t|
        if ((t.chat_ready == true) && (t.setup == true))
          x.push(t)
        end
      end
      tutes = x.sample
      if tutes.nil?
        redirect_to '/users/new_chat', alert: 'Sorry, but there are currently no tutors available for an instant chat session in that course.'
      else
        @room.start = DateTime.now.utc
        current_user.chatroom = @room
        tutes.chatroom = @room
        @room.save!

        tutes.chat_ready = false
        tutes.session_count += 1
        tutes.notifications.destroy_all
        tutes.save!

        notify = Notification.new
        notify.tutor_id = tutes.id
        notify.chatroom_id = @room.id
        notify.save!
        ActionCable.server.broadcast "notifications:#{notify.tutor.id}", {
          notification: Tutors::NotificationsController.render(notify),
          tutor_id: notify.tutor.id
        }

        respond_to do |format|
          format.html { redirect_to @room, alert: 'Welcome. Type to chat. Once you are finished, please log out. You will be charged for the duration of the chat.' }
          format.json { head :no_content }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to root_path, alert: 'Sorry, but there are currently no tutors available for an instant chat session in that course.' }
        format.json { head :no_content }
      end

    end
  end

  def show
    @coursename = Course.find(@chatroom.course_id).name
    @tutor = Tutor.find(@chatroom.tutor_id)
    @user = User.find(@chatroom.user_id)
    @messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse

    rescue ActiveRecord::RecordNotFound
      redirect_to root_path, alert: 'Your chat session has ended.'
  end

  private
    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        redirect_to root_path, alert: 'Your chat session has ended.'
    end

    def chatroom_params
      params.require(:chatroom).permit(:user_id, :tutor_id, :course_id, :topic, :start, :finish)
    end

end
