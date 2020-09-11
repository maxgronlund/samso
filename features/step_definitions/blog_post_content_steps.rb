Then("I visit an article page") do

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

  visit admin_blog_blog_post_path(I18n.locale, blog_post.blog, blog_post)
end

Then("I fill the blog_post_content_form and submit it") do
  blog_post_content_form_data = persisted_fake_blog_post_content_form_data
  click_on I18n.t('save')
end

Then("I can see the blog_post_content i created") do
  pending # Write code here that turns the phrase above into concrete actions
end
