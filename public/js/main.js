var chatInit = function () {
  Faye.Logging.logLevel = 'info';
  Faye.logger = function (msg) {
    if (window.console) console.log(msg);
  };

  var client = new Faye.Client(faye_path, {
    timeout: 120
  });

  var chatInfo = {
    outgoing: function(message, callback) {
      // Leave non-subscribe messages alone
      if (message.channel !== '/meta/subscribe') return callback(message);

      message.user = user;
      message.room = room;

      callback(message);
    }
  };

  client.addExtension(chatInfo);

  var chat_subscription = client.subscribe('/chat/' + room, function (message) {
    addChatMessage(message);
  });

  var activity_subscription = client.subscribe('/activity/' + room, function (activity) {
    addActivityMessage(activity);
  });

  $('#sendMessage').submit(function (e) {
    var text = $('#newMessage').val();

    client.publish("/chat/" + room, {
      user: user,
      text: text,
      room: room
    });

    $('#newMessage').val('');

    e.preventDefault();
  });
};

var addChatMessage = function (message) {
  var html = '<div class="message"><div class="user">' + message.user.short_name + '</div><div class="body">' + message.text + '</div></div>';
  $("#messages").append(html);
};

var addActivityMessage = function (activity) {
  var html = '<div class="message"><div class="user">' + activity.short_name + '</div><div class="body">has entered the room.</div></div>';
  $("#messages").append(html);
};