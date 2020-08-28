# seeds file runs every deployment since it is a task in the release
# I couldn't figure out a way to trigger a rake task via Heroku Platform API other than using the release mechanism
if AdminUser.count == 0 # only run once
  AdminUser.create(email: 'admin@example.com', password: 'password')
end
