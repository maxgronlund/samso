Then('I submit the signup form with {string}, {string}, {string}') do |name, email, password|
  fill_in 'user_name', with: name
  fill_in 'user_email', with: email
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with: password
  fill_in 'user_addresses_attributes_0_first_name', with: "First-Name"
  fill_in 'user_addresses_attributes_0_middle_name', with: "Middle-Name"
  fill_in 'user_addresses_attributes_0_last_name', with: "Last-Name"
  fill_in 'user_addresses_attributes_0_street_name', with: "Street-Name"
  fill_in 'user_addresses_attributes_0_house_number', with: "3"
  fill_in 'user_addresses_attributes_0_zipp_code', with: "7773"
  fill_in 'user_addresses_attributes_0_city', with: "Some city"
  find_by_id('submit').click

end

When('I login as {string} with the password {string}') do |email, password|
  visit new_session_path
  fill_in 'email', with: email
  fill_in 'password', with: password
  find_by_id('log-in').click
end
