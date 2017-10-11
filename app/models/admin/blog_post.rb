# Post in the blog
class Admin::BlogPost < ApplicationRecord
  belongs_to :blog, class_name: 'Admin::Blog', counter_cache: true
  belongs_to :user, class_name: 'User', counter_cache: true
  has_attached_file :image, styles: {
    medium: '300x300>',
    thumb: '100x100>'
  }
  include PgSearch
  multisearchable against: %i[title body]
  pg_search_scope :search_by_title_or_body, against: %i[title body]

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def page
    blog_module.page
  end

  def image_url(size)
    image.url(size)
  end

  def clear_page_cache
    blog.clear_cache_on_pages
  end
end
