class Admin::BlogPostContent < ApplicationRecord
  belongs_to :admin_blog_post, class_name: 'Admin::BlogPost'

  # validates :image, presence: true

  after_commit :reindex_admin_blog_post

  def reindex_admin_blog_post
    admin_blog_post.reindex
  end

  has_attached_file :image,
  styles: {
    thumb: '250x200#',
    full_size: '750x600#'
  },
  convert_options: {
    thumb: '-quality 75 -strip',
    full_size: '-quality 75 -strip'
  }

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
end
