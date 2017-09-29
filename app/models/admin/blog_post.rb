# Post in the blog
class Admin::BlogPost < ApplicationRecord
  belongs_to :blog_module, class_name: 'Admin::BlogModule', counter_cache: true
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

  def blog
    blog_module
  end

  def image_url(size)
    source = 'https://s3.eu-central-1.amazonaws.com' + image.url(size).gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/avatars/square/missing.png'
      source = 'https://s3.eu-central-1.amazonaws.com/samso-files/users/avatars/missing/#{size.to_s}/missing.png'
    end
    source
    image.url(size)
  end

  def post_page
    blog_module.show_on_page
  end
end
