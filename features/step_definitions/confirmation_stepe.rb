Then('I can see a {string} link') do |string|
  page.should have_content(I18n.t(string))
end

Then('I can see the login page') do
  page.should have_content(I18n.t('login'))
  page.should have_content(I18n.t('forgot_password'))
  page.should have_content(I18n.t('signup'))
end

Then('I can see the signup page') do
  page.should have_content(I18n.t('user.create'))
end

Then('I can see the {string} link') do |string|
  page.should have_content(I18n.t(string))
end

Then('I can see the thanks for signing up screen') do
  message = Admin::SystemMessage.thanks_for_signing_up
  page.should have_content(message.title)
  page.should have_content(message.body)
end

Then('the user can confirm the account') do
  message = Admin::SystemMessage.welcome
  visit confirm_signup_path(I18n.locale, 'c1af8d4a2b41a1f25c93d0c9cda4243ed85bb059f09e99056d5f81fb091b3c94')
  page.should have_content(message.title)
  page.should have_content(message.body)
end
