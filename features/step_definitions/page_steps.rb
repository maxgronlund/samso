Given('there is a page where the blog is given access to {string}') do |access_to|
  page = page_with_title(access_to, 'menu_bar')

  page_row = page.page_rows.create(layout: 'row')

  page_row_service =
    PageRow::Service.new(page_row)
  page_row_service
    .create_page_cols('8-4')

  blog =
    FactoryGirl
    .create(:blog)

  FactoryGirl
    .create(
      :blog_post,
      blog_id: blog.id,
      title: 'Blog post',
      user_id: super_user.id
    )

  blog_module =
    FactoryGirl
    .create(:blog_module, admin_blog_id: blog.id)

  page_col = page_row.page_cols.first
  page_col
    .page_col_modules
    .create(
      page_col_id: page_col.id,
      moduleable_type: blog_module.class.name,
      moduleable_id: blog_module.id,
      access_to: access_to
    )
end

Given("there is a page with a {string} where access_to is set to {string}") do |module_type, access_to|
  page = page_with_title('Post page', 'not_in_any_menus')

  page_row = page.page_rows.create(layout: 'row')

  page_row_service =
    PageRow::Service.new(page_row)
  page_row_service
    .create_page_cols('8-4')

  subscription_module =
    FactoryGirl
    .create(:subscription_module)

  page_col = page_row.page_cols.first
  page_col
    .page_col_modules
    .create(
      page_col_id: page_col.id,
      moduleable_type: subscription_module.class.name,
      moduleable_id: subscription_module.id,
      access_to: access_to
    )
end
