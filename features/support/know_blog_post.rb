# Helper for creating blog_posts
module KnowBlogPostHelper
  def create_blog_post(options = {})
    blog_id = options[:blog_id]
    title = options[:title] || 'Blog post'
    user_id = options[:user_id] || User.first.id
    free_content = options[:free_content] || true
    FactoryGirl
      .create(
        :blog_post,
        blog_id: blog_id,
        title: title,
        user_id: user_id,
        free_content: free_content
      )
  end

  def persisted_fake_blog_post_form_data
    @persisted_fake_blog_post_form_data ||=
      {
        title: Faker::Beer.name,
        subtitle: Faker::Hipster.sentence,
        teaser: Faker::HowIMetYourMother.quote,
        body: Faker::Hipster.paragraph,
        free_content: true,
        signature: Faker::Name.name
      }
  end
end

World(KnowBlogPostHelper)
