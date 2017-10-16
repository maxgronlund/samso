Given('the site is ready') do
  page = FactoryGirl
    .create(
      :page,
      user_id: super_user.id
    )
  FactoryGirl
    .create(
      :system_setup,
      landing_page_id: page.id
    )
end
