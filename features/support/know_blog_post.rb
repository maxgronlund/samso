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
end

World(KnowBlogPostHelper)
