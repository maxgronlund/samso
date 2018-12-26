Given('there is a {string} with the email {string} and the password {string}') do |role, email, password|
  user =
    create_user(
      email: email,
      password: password,
      permission: role,
      confirmed_at: DateTime.now
    )

  subscription_type = internet_subscription_type('Online access')
  case role
  when 'valid-subscriber'
    create_valid_subscription_for(user, subscription_type)
  when 'expired-subscriber'
    create_expired_subscription_for(user, subscription_type)
  end
end

Then('I visit my account page') do
  user = User.find_by(email: 'valid-subscriber@example.com')
  visit user_path(I18n.locale, user.id)
end

Then('I can see my account') do
  user = User.find_by(email: 'valid-subscriber@example.com')
  expect(user_path(I18n.locale, user.id)).to have_content(current_path)
  expect(page).to have_content(I18n.t('edit'))
  expect(page).to have_content(user.name)
end

Then('I can change my address') do
  user = User.find_by(email: 'valid-subscriber@example.com')
  name = Faker::Name.name
  city = Faker::Address.city
  zipp_code = '8520'
  fill_in 'user_name', with: name
  fill_in 'user_addresses_attributes_0_address', with: Faker::Address.street_address
  fill_in 'user_addresses_attributes_0_zipp_code', with: zipp_code
  fill_in 'user_addresses_attributes_0_city', with: city
  click_on I18n.t('save')
  expect(page).to have_content(name)
  expect(page).to have_content(city)
  expect(page).to have_content(zipp_code)
end
