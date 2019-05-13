class Admin::BlogPostImage < ApplicationRecord
  belongs_to :admin_blog_post, class_name: 'Admin::BlogPost'

  validates :image, presence: true

  has_attached_file :image,
  styles: {
    thumb: "250x200#",
    full_size: "750x600#"
  },
  convert_options: {
    thumb: "-quality 75 -strip",
    full_size: "-quality 75 -strip"
  }

  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def next_postion
    position = 10
  end
end
