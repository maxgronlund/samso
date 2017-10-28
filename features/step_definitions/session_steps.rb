Then('I submit the signup form with {string}, {string}, {string}') do |name, email, password|
  fill_in 'user_name', with: name
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password
  find_by_id('submit').click
end

When('I login as {string} with the password {string}') do |email, password|
  visit new_session_path
  fill_in 'email', with: email
  fill_in 'password', with: password
  find_by_id('log-in').click
end
