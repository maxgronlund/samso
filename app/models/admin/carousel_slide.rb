# Slides for the carousel module
class Admin::CarouselSlide < ApplicationRecord
  belongs_to :carousel_module, class_name: 'Admin::CarouselModule'
  belongs_to :page, optional: true

  has_attached_file :image, styles: {
    thumb: '180x60#',
    '12_col_4x1'.to_sym => '1200x400#',
    '9_coll_3x1'.to_sym => '900x300#',
    '6_coll_2x1'.to_sym => '600x300#',
    default_url: 'style/missing_squarde_image.jpg'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}
  validates :carousel_module, :image, :title, presence: true

  def parrent_page
    carousel_module.page_module.page
  end

  def image_url(size)
    source = 'https://s3.eu-central-1.amazonaws.com' + image.url(size).gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/image/square/missing.png'
      source = 'https://s3.eu-central-1.amazonaws.com/samso-files/admin_carousel_slides/images/missing/#{size.to_s}/missing.png'
    end
    source
  end
end
