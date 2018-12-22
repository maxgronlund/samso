Given('there is a blog page with {int} blog posts') do |nr_posts|
  post_module = FactoryBot.create(:post_module)
  create_page_with_module(
    title: 'post_module_page',
    moduleable: post_module
  )
  blog = FactoryBot.create(:blog)

  create_blog_module_page(
    blog_id: blog.id
  )

  nr_posts.times do
    FactoryBot
      .create(
        :admin_blog_post,
        blog_id: blog.id,
        free_content: true
      )
  end
end

Then('I visit the articles page') do
  visit admin_articles_path
end

Then('I fill the form and submit it') do
  blog_post_form_data = persisted_fake_blog_post_form_data
  fill_in 'admin_blog_post_title', with: blog_post_form_data[:title]
  fill_in 'admin_blog_post_subtitle', with: blog_post_form_data[:subtitle]
  fill_in 'admin_blog_post_teaser', with: blog_post_form_data[:teaser]
  click_on I18n.t('save')
end

Then('I can see the post I created') do
  post = persisted_fake_blog_post_form_data
  expect(page).to have_content(post[:title])
end
