class ActivityNotifier

  def incoming(message, callback)

    # Don't mess with meta messages

    unless message['channel'] == '/meta/subscribe' and message['subscription'].starts_with?('/chat/')
      return callback.call(message)
    end

    user = User.find(message['user']['id'])
    room = Room.find(message['room'])

    Server.get_client.publish("/activity/#{room.id}", {
      id: user.id.to_s,
      short_name: user.short_name
    })

    # Call the server back now we're done
    callback.call(message)
  end
end
