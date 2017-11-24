Given('the user {string} has a {string}') do |email, subscription|
  user = User.find_by(email: email)
  subscription_type = internet_subscription_type('internet and print')
  if subscription == 'valid-subscription'
    create_valid_subscription_for(user, subscription_type)
  else
    create_expired_subscription_for(user, subscription_type)
  end
end

Given('there is a page with a text module and a subscription module') do
  text_module =
    FactoryBot
    .create(
      :text_module,
      title: 'subscribers_only'
    )
  page = create_page_with_module(
    title: 'subscribers_only',
    moduleable: text_module,
    access_to: 'subscribers_only'
  )

  subscription_module = FactoryBot.create(:subscription_module)
  add_module_to_page(
    moduleable: subscription_module,
    page: page,
    access_to: 'all_without_valid_subscription'
  )
end
