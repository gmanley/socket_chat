require File.expand_path('../../lib/support/boot', __FILE__)
user1 = User.create(email: "gray.manley@gmail.com", password: "password", password_confirmation: "password", first_name: "Grayson", last_name: "Manley")
user2 = User.create(email: "example@example.com", password: "password", password_confirmation: "password", first_name: "John", last_name: "Doe")
room = Room.create(name: 'Main')
room.users.push(user1, user2)
