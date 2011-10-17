head(function() {

  var client = new Faye.Client(faye_path, {
      timeout: 120
  });

  var subscription = client.subscribe('/chat', function(message) {
    addMessage(message.user, message.message);
  });

  var user = 'Gray';

  $('form#sendMessage').submit(function(e) {
    var message = $('#newMessage').val();

    client.publish("/chat", {
      user: user,
      message: message
    });
    $('#newMessage').val('');

    e.preventDefault();
  });

  var addMessage = function(user, message) {
    $("#messages").append('<div class="message"></div>')
    .append('<div class="message"><div class="user">' + user + '</div><div class="body">' + message + '</div></div>');
  };
});

