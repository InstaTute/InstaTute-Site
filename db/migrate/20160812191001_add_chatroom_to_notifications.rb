class AddChatroomToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :chatroom, foreign_key: true
  end
end
