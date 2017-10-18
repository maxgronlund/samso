Given('there there is a user with the email {string} and the password {string}') do |email, password|
  member(email, password)
end

Given("there there is a {string} with the email {string} and the password {string}") do |role, email, password|
  user = member(email, password)
  subscription_type = internet_subscription_type('Online access')
  case role
  when 'valid-subscriber'
    create_valid_subscription_for(user, subscription_type)
  when 'expired-subscriber'
    create_expired_subscription_for(user, subscription_type)
  end
end

When('an unconfirmed user has signed up') do
  unconfirmed_user
end

When('I login as {string} with the password {string}') do |email, password|
  visit new_session_path
  fill_in 'email', with: email
  fill_in 'password', with: password
  find_by_id('log-in').click
end
