# Image for the gallery
class Admin::GalleryImage < ApplicationRecord
  belongs_to :gallery_module, class_name: 'Admin::GalleryModule'
  belongs_to :user

  has_attached_file :image, styles: {
    default: '640x640>',
    squared: '526x526#',
    full_size: '1110x1110>',
    default_url: 'style/missing_squarde_image.jpg'
  }

  # Validate the attached image is image/jpg, image/png, etc
  validates_attachment_content_type :image, content_type: %r{\Aimage\/.*\Z}

  def image_url(size)
    source = 'https://s3.eu-central-1.amazonaws.com' + image.url(size).gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/image/square/missing.png'
      source = 'https://s3.eu-central-1.amazonaws.com/samso-files/admin_gellery_images/images/missing/#{size.to_s}/missing.png'
    end
    source
  end

  def page
    gallery_module.page
  end

  def user_name
    user ? user.name : ''
  end
end
