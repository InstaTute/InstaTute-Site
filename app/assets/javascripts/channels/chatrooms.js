App.chatrooms = App.cable.subscriptions.create("ChatroomsChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    return $("[data-behavior='messages'][data-chatroom-id='" + data.chatroom_id + "']").append(data.message);
  }
});
