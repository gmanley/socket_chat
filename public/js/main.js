head(function () {

  Faye.Logging.logLevel = 'info';
  Faye.logger = function (msg) {
    if (window.console) console.log(msg);
  };

  var client = new Faye.Client(faye_path, {
    timeout: 120
  });

  var subscription = client.subscribe('/chat', function (message) {
    addMessage(message);
  });

  $('form#login').submit(function (e) {
    var params = $(this).serialize();

    $.post($(this).attr("action"), params, function (response) {
      if (response.success) {
        var user = response.user;
        $('#access_notice').replaceWith(response.chatbox);
        $('.topbar').first().replaceWith(response.topbar);
      } else {
        var error_message = '<div class="alert-message error login-message"><p><strong>' + response.error + '!</strong></p></div>';
        $(".topbar .fill .container form").append(error_message);
        $(".login-message").wiggle({
          waggle: 3,
          duration: 2
        }, function (elem) {
          $(elem).fadeOut('slow');
        });
      }
    });

    e.preventDefault();
  });

  $('#sendMessage').submit(function (e) {
    var text = $('#newMessage').val();

    client.publish("/chat", {
      user: user,
      text: text
    });

    $('#newMessage').val('');

    e.preventDefault();
  });

  var addMessage = function (message) {
    var html = '<div class="message"><div class="user">' + message.user.short_name + '</div><div class="body">' + message.text + '</div></div>';
    $("#messages").append(html);
  };
});