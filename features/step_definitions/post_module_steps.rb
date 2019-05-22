Given('there is blog page with a free and protected blog post') do
  blog = FactoryBot.create(:blog)

  blog_module =
    FactoryBot
    .create(
      :blog_module,
      admin_blog_id: blog.id,
      show_search: false,
      show_all_categories: true
    )

  blog_post =
    FactoryBot
    .create(
      :blog_post,
      title: 'free_content',
      blog_id: blog.id,
      free_content: true
    )

  FactoryBot
    .create(
      :blog_post_stat,
      admin_blog_post_id: blog_post.id,
      start_date: blog_post.start_date
    )

  blog_post =
    FactoryBot
    .create(
      :blog_post,
      title: 'protected_content',
      blog_id: blog.id,
      free_content: false
    )

  FactoryBot
    .create(
      :blog_post_stat,
      admin_blog_post_id: blog_post.id,
      start_date: blog_post.start_date
    )

  index_page =
    create_page_with_module(
      title: 'Index page',
      moduleable: blog_module
    )

  post_module = FactoryBot.create(:post_module)
  show_page =
    create_page_with_module(
      title: 'Show page',
      moduleable: post_module
    )

  blog.update(
    show_page_id: show_page.id,
    index_page_id: index_page.id
  )
end

When('I visit the blog page and click on the {string} blog post') do |blog_post_title|
  index_page = Page.find_by(title: 'Index page')
  visit page_path(I18n.locale, index_page)
  click_on blog_post_title
end
