# Helper for creating blog_posts
module KnowBlogPostCategoryHelper
  def create_blog_post_category(options = {})
    locale = options[:locale] || I18n.locale
    name = options[:name] || Faker::Name.name
    active = options[:active] || true

    FactoryGirl
      .create(
        :blog_post_category,
        locale: locale,
        name: name,
        active: active
      )
  end
end

World(KnowBlogPostCategoryHelper)
