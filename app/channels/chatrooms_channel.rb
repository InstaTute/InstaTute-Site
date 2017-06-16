# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    room = current.chatroom
    stream_from "chatrooms:#{room.id}"
  end

  def unsubscribed
    stop_all_streams
    room = current.chatroom
    if room.finished == true
      tutor = Tutor.find(room.tutor.id)
      tutor.chat_ready = true
      tutor.save!
      user = User.find(room.user_id)
      user.rate_lock = true
      user.last_tutor_id = tutor.id
      user.save!
      room.destroy!
    end
  end
end
