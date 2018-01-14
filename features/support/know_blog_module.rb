# Helper for creating blog_posts
module KnowBlogModuleHelper
  def create_blog_module_page(options = {})
    blog_id = options[:blog_id]
    blog_module =
      FactoryBot
      .create(
        :blog_module,
        admin_blog_id: blog_id,
        show_search: false,
        show_all_categories: true
      )

    create_page_with_module(
      title: 'blog_module_page',
      moduleable: blog_module
    )
  end
end

World(KnowBlogModuleHelper)
