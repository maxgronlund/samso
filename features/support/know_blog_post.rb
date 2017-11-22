# Helper for creating blog_posts
module KnowBlogPostHelper
  def create_blog_post(options = {})
    blog_id = options[:blog_id]
    title = options[:title] || 'Blog post'
    user_id = options[:user_id] || User.first.id
    free_content = options[:free_content] || true
    admin_blog_post_category_id = options[:admin_blog_post_category_id]
    FactoryGirl
      .create(
        :blog_post,
        blog_id: blog_id,
        title: title,
        user_id: user_id,
        free_content: free_content,
        admin_blog_post_category_id: admin_blog_post_category_id
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

  # private

  # def find_or_create_category
  #   Admin::BlogPostCategory
  #     .where(category_options)
  #     .first_or_create(category_options)
  # end

  # def category_options
  #   {
  #     locale: I18n.locale,
  #     name: 'default',
  #     active: true,
  #     page_id: 1
  #   }
  # end
end

World(KnowBlogPostHelper)
