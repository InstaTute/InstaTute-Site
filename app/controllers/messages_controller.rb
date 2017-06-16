class MessagesController < ApplicationController
  before_action :set_chatroom
  def create
    message = @chatroom.messages.build(message_params)
    message.first_name = current_person.first_name
    message.save
    ActionCable.server.broadcast "chatrooms:#{message.chatroom_id}",{
    message: MessagesController.render(message),
    first_name: message.first_name,
    chatroom_id: message.chatroom_id
    }
  end

  private
    def message_params
      params.require(:message).permit(:content,:id)
    end

    def set_chatroom
      @chatroom = Chatroom.find(params[:id])
    end
end
