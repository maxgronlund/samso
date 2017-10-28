Given('there is a {string} with the email {string} and the password {string}') do |role, email, password|
  user =
    create_user(
      email: email,
      password: password,
      permission: Role::MEMBER,
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
