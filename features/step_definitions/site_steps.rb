Given('the site is ready') do
  page =
    FactoryGirl
    .create(
      :page,
      user_id: super_user.id,
      title: 'Front page',
      menu_title: 'Front page'
    )

  FactoryGirl
    .create(
      :system_setup,
      landing_page_id: page.id
    )

  FactoryGirl
    .create(
      :system_message,
      title: 'welcome',
      locale: 'en',
      body: 'Welcome to this awesome site'
    )
end
