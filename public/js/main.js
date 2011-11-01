head(function () {

  Faye.Logging.logLevel = 'info';
  Faye.logger = function (msg) {
    if (window.console) console.log(msg);
  };

  var client = new Faye.Client(faye_path, {
    timeout: 120
  });

  var subscription = client.subscribe('/chat/' + room, function (message) {
    addMessage(message);
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

  var addMessage = function (message) {
    var html = '<div class="message"><div class="user">' + message.user.short_name + '</div><div class="body">' + message.text + '</div></div>';
    $("#messages").append(html);
  };
});