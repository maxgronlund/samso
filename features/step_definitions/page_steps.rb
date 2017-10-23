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
      user_id: super_user.id,
      free_content: true
    )

  blog_module =
    FactoryGirl
    .create(:blog_module, admin_blog_id: blog.id)

  page_col = page_row.page_cols.first
  page_col
    .page_col_modules
    .create(
      moduleable_type: blog_module.class.name,
      moduleable_id: blog_module.id,
      access_to: access_to
    )
end

Given('there is a page named {string} with a text module with the title {string} and a subscription module') do |page_title, text_module_title|
  page = page_with_title(page_title, 'not_in_any_menus')

  page_row = page.page_rows.create(layout: 'row')

  page_row_service =
    PageRow::Service.new(page_row)
  page_row_service
    .create_page_cols('8-4')

  FactoryGirl.create(:subscription_type)

  subscription_module =
    FactoryGirl
    .create(:subscription_module)

  text_module =
    FactoryGirl
    .create(
      :text_module,
      title: text_module_title
    )

  page_col = page_row.page_cols.first
  page_col
    .page_col_modules
    .create(
      moduleable_type: subscription_module.class.name,
      moduleable_id: subscription_module.id,
      access_to: 'all_without_valid_subscription'
    )

  page_col
    .page_col_modules
    .create(
      moduleable_type: text_module.class.name,
      moduleable_id: text_module.id,
      access_to: 'subscribers_only'
    )
end
