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

Then('I can see the thanks for signing up screen') do
  message = Admin::SystemMessage.thanks_for_signing_up
  expect(page).to have_content(message.title)
  expect(page).to have_content(message.body)
end

Then('the user can confirm the account') do
  message = Admin::SystemMessage.welcome
  visit confirm_signup_path(I18n.locale, 'c1af8d4a2b41a1f25c93d0c9cda4243ed85bb059f09e99056d5f81fb091b3c94')
  expect(page).to have_content(message.title)
  expect(page).to have_content(message.body)
end

Then('I can not see the blog') do
  expect(page).to_not have_content('Blog post')
end

Then('I can see the blog') do
  expect(page).to have_content('Blog post')
end
