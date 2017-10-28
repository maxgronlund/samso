# Helper for creating blog_posts
module KnowBlogModuleHelper
  def create_blog_module_page(options = {})
    post_module_page_id = options[:post_module_page_id]
    blog_id = options[:blog_id]
    blog_module =
      FactoryGirl
      .create(
        :blog_module,
        admin_blog_id: blog_id,
        post_page_id: post_module_page_id
      )

    create_page_with_module(
      title: 'blog_module_page',
      moduleable: blog_module
    )
  end
end

World(KnowBlogModuleHelper)
