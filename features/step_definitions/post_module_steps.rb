Given('there is blog page with a free and protected blog post') do
  post_module = FactoryGirl.create(:post_module)
  post_page =
    create_page_with_module(
      title: 'post_module_page',
      moduleable: post_module
    )
  blog        = FactoryGirl.create(:blog)
  blog_module =
    FactoryGirl
    .create(
      :blog_module,
      admin_blog_id: blog.id,
      post_page_id: post_page.id
    )

  create_page_with_module(
    title: 'blog_module_page',
    moduleable: blog_module
  )

  FactoryGirl
    .create(
      :blog_post,
      title: 'free_content',
      blog_id: blog.id,
      free_content: true
    )

  FactoryGirl
    .create(
      :blog_post,
      title: 'protected_content',
      blog_id: blog.id,
      free_content: false
    )
end

When('I visit the blog page and click on the {string} blog post') do |blog_post_title|
  blog_module_page = Page.find_by(title: 'blog_module_page')
  visit page_path(I18n.locale, blog_module_page)
  click_on blog_post_title
end
