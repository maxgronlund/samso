Given('there is a page where a text_module is visible to {string}') do |access_to|
  text_module =
    FactoryBot
    .create(
      :text_module,
      title: access_to
    )
  create_page_with_module(
    title: access_to,
    moduleable: text_module,
    access_to: access_to
  )
end
