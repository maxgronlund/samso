Then('I can see a {string} link') do |string|
  expect(page).to have_content(I18n.t(string))
end

Then('I can see the login page') do
  expect(page).to have_content(I18n.t('login'))
  expect(page).to have_content(I18n.t('forgot_password'))
  expect(page).to have_content(I18n.t('signup'))
end

Then('I can see the signup page') do
  expect(page).to have_content(I18n.t('user.create'))
end

Then('I can see the {string} link') do |string|
  expect(page).to have_content(I18n.t(string))
end

Then('I can not see a {string} link') do |string|
  expect(page).to_not have_content(I18n.t(string))
end

Then('I can see the thanks for signing up screen') do
  message = Admin::SystemMessage.thanks_for_signing_up
  expect(page).to have_content(message.title)
  expect(page).to have_content(message.body)
end

Then('I can see {string}') do |string|
  expect(page).to have_content(string)
end

Then('I can not see {string}') do |string|
  expect(page).to_not have_content(string)
end
