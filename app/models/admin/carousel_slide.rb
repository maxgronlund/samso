# Slides for the carousel module
class Admin::CarouselSlide < ApplicationRecord
  belongs_to :carousel_module, class_name: 'Admin::CarouselModule'
  belongs_to :page

  has_attached_file :image, styles: {
    thumb: '180x60#',
    '12_col_3x1'.to_sym => '1200x400#',
    '6_coll_1x1'.to_sym => '600x300#',
    default_url: 'style/missing_squarde_image.jpg'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

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
