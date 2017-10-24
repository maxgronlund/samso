# Post in the blog
class Admin::BlogPost < ApplicationRecord
  attr_accessor :delete_image, :page_id
  belongs_to :blog, class_name: 'Admin::Blog', counter_cache: true
  belongs_to :user, class_name: 'User', counter_cache: true, optional: true
  belongs_to :admin_blog_post_category, class_name: 'Admin::BlogPostCategory', optional: true
  has_attached_file :image, styles: {
    medium: '300x300>',
    thumb: '100x100>',
    large: '770x770>',
    full_size: '1110x1110>'
  }
  include PgSearch
  multisearchable against: %i[title body]
  pg_search_scope :search_by_title_or_body, against: %i[title body]

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  before_validation { image.clear if delete_image == '1' }

  LAYOUTS =
    [
      ['image_top', 'image_top'],
      ['image_left', 'image_left'],
      ['image_right', 'image_right'],
    ].freeze

  def page
    blog_module.page
  end

  def image_url(size)
    image.url(size)
  end

  def clear_page_cache
    blog.clear_cache_on_pages
  end

  def category_name
    return '' if admin_blog_post_category.nil?
    admin_blog_post_category.name
  end

  def author_name
    return '' unless user
    user.name
  end
end

