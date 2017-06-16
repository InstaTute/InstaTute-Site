App.notifications = App.cable.subscriptions.create("NotificationsChannel", {
  connected: function() {},
  disconnected: function() {},
  received: function(data) {
    return $("[data-behavior='notifications'][data-notification-id='" + data.tutor_id + "']").append(data.notification);
  }
});
