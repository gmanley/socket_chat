Room.blueprint do
  name { "#{Faker::Company.bs} Room".titleize }
end

User.blueprint do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.free_email("#{object.first_name} #{object.last_name}") }
  password { "password" }
  password_confirmation { object.password }
end