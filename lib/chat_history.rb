module SocketChat
  class ChatHistory
    def incoming(message, callback)

      # Don't mess with meta messages
      if message['channel'].start_with?('/meta/')
        return callback.call(message)
      end

      user = User.find(message['data']['user']['id'])
      logged_message = user.messages.new(:text => message['data']['text'])
      logged_message.save!

      # Call the server back now we're done
      callback.call(message)
    end
  end
end