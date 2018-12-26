# Helper for creating blog_posts
module KnowBlogModuleHelper
  def create_blog_module_page(options = {})
    blog_id = options[:blog_id]
    title = options[:title] || 'blog_module_page'
    blog_module =
      FactoryBot
      .create(
        :blog_module,
        admin_blog_id: blog_id,
        show_search: false,
        show_all_categories: true
      )

    create_page_with_module(
      title: title,
      moduleable: blog_module
    )
  end
end

World(KnowBlogModuleHelper)
