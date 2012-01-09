class ChatHistory

  def incoming(message, callback)

    # Don't mess with meta messages
    return callback.call(message) unless message['channel'].start_with?('/chat/')

    user = User.find(message['data']['user']['id'])
    room = Room.find(message['data']['room'])
    user.messages << room.messages.create(text: message['data']['text'])

    # Call the server back now we're done
    callback.call(message)
  end
end
