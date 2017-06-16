# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class NotificationsChannel < ApplicationCable::Channel
  def subscribed
    if current.class == "Tutor"
      stream_from "notifications:#{current.id}"
    end
  end

  def unsubscribed
    stop_all_streams
    if current.class == "Tutor"
      current.chat_ready = false
      current.save!
    end
  end
end
