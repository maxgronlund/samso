Given('the site is ready') do
  page =
    FactoryBot
    .create(
      :page,
      title: 'Front page',
      menu_title: 'Front page'
    )

  FactoryBot
    .create(
      :system_setup,
      landing_page_id: page.id
    )

  FactoryBot
    .create(
      :system_message,
      title: 'welcome',
      locale: I18n.locale,
      body: 'Welcome to this awesome site'
    )
end
