# Helper for creating blog_posts
module KnowBlogPostContentHelper
  def create_blog_post_content(options = {})
    blog_post_id = options[:blog_post_id]

    FactoryBot
      .create(
        :blog_post_content,
        blog_post_id: blog_post_id,
      )
  end

  def persisted_fake_blog_post_content_form_data
    @persisted_fake_blog_post_content_form_data ||=
      {body: Faker::Hipster.paragraph}
  end
end

World(KnowBlogPostContentHelper)
