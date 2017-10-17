Given('there there is a user with the email {string} and the password {string}') do |email, password|
  member(email, password)
end

When('an unconfirmed user has signed up') do
  unconfirmed_user
end
