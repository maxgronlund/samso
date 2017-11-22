Given('there is a blog page with {int} blog posts') do |nr_posts|
  post_module = FactoryGirl.create(:post_module)
  post_module_page =
    create_page_with_module(
      title: 'post_module_page',
      moduleable: post_module
    )
  blog = FactoryGirl.create(:blog)

  page = create_blog_module_page(
    blog_id: blog.id,
    post_module_page_id: post_module_page.id
  )

  blog_post_category =
    create_blog_post_category(
      page_id: page.id,
      name: 'default'
    )

  nr_posts.times do
    FactoryGirl
      .create(
        :blog_post,
        blog_id: blog.id,
        title: Faker::HeyArnold.quote,
        subtitle: Faker::Hipster.sentence,
        teaser: Faker::HowIMetYourMother.quote,
        body: Faker::Hipster.paragraph,
        free_content: true,
        signature: Faker::Name.name,
        admin_blog_post_category_id: blog_post_category.id
      )
  end
end

Then('I visit the blog page') do
  blog_module_page = Page.find_by(title: 'blog_module_page')
  visit page_path(I18n.locale, blog_module_page)
end

Then('I can see the new blog post form') do
  expect(page).to have_content(I18n.t('blog_post.new'))
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
