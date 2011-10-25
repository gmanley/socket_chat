head(function() {

  Faye.Logging.logLevel = 'info';
  Faye.logger = function(msg) { if (window.console) console.log(msg) };

  var client = new Faye.Client(faye_path, {
      timeout: 120
  });

  var subscription = client.subscribe('/chat', function(message) {
    addMessage(message);
  });


  $('form#login').submit(function(e) {
    var params = $(this).serialize();

    $.post($(this).attr("action"), params,
      function(response) {
        if (response.success) {
          console.log("Sucess!");
        } else {
          var error_template = '<div class="alert-message error login-message"><p><strong>{{error}}!</strong></p></div>';
          var html = Mustache.to_html(error_template, response);
          $(".topbar .fill .container form").append(html);
          $(".login-message").wiggle({
              waggle : 3,
              duration : 2
          }, function (elem) {
            $(elem).fadeOut('slow');
          });
        }
      }
    );

    e.preventDefault();
  });

  $('form#sendMessage').submit(function(e) {
    var message = $('#newMessage').val();

    client.publish("/chat", {
      user: user,
      message: message
    });
    $('#newMessage').val('');

    e.preventDefault();
  });

  var addMessage = function(message) {
    var template = '<div class="message"><div class="user">{{user}}</div><div class="body">{{message}}</div></div>';

    var html = Mustache.to_html(template, message);
    $("#messages").append(html);
  };
});