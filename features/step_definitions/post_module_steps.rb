Given('there is blog page with a free and protected blog post') do
  post_module = FactoryBot.create(:post_module)
  post_module_page =
    create_page_with_module(
      title: 'post_module_page',
      moduleable: post_module
    )
  blog = FactoryBot.create(:blog)

  create_blog_module_page(
    blog_id: blog.id
  )

  FactoryBot
    .create(
      :blog_post,
      title: 'free_content',
      blog_id: blog.id,
      free_content: true,
      post_page_id: post_module_page.id
    )

  FactoryBot
    .create(
      :blog_post,
      title: 'protected_content',
      blog_id: blog.id,
      free_content: false,
      post_page_id: post_module_page.id
    )
end

When('I visit the blog page and click on the {string} blog post') do |blog_post_title|
  blog_module_page = Page.find_by(title: 'blog_module_page')
  visit page_path(I18n.locale, blog_module_page)
  click_on blog_post_title
end
