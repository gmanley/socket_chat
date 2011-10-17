// head(function() {
//
// });

FAYE_DEBUG = true;

Logger = {
  incoming: function(message, callback) {
    console.log('incoming', message);
    callback(message);
  },
  outgoing: function(message, callback) {
    console.log('outgoing', message);
    callback(message);
  }
};

if (FAYE_DEBUG) {
  client.addExtension(Logger);
};

var client = new Faye.Client('/faye', {
    timeout: 120
});

var subscription = client.subscribe('/chat', function(message) {
  // handle message
});