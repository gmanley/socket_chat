Fabricator(:message) do
  text { Faker::Lorem.sentence }
  user!
end

Fabricator(:room) do
  name { "#{Faker::Company.bs} Room".titleize }
end

Fabricator(:user) do
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { |user| Faker::Internet.free_email("#{user.first_name} #{user.last_name}") }
  password "password"
  password_confirmation { |user| user.password }
end