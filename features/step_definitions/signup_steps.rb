When('I signup with the email {string} and the password {string}') do |email, password|
  create_user(
    email: email,
    password: password,
    permission: Role::MEMBER,
    confirmation_token: SecureRandom.uuid,
    confirmation_sent_at: DateTime.now
  )
end

Then('the user with the email {string} can confirm the account') do |email|
  user = User.find_by(email: email)
  message = Admin::SystemMessage.welcome
  visit confirm_signup_path(I18n.locale, user.confirmation_token)
  expect(page).to have_content(message.title)
  expect(page).to have_content(message.body)
end
