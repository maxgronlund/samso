# frozen_string_literal: true

# Image for the gallery
class Admin::GalleryImage < ApplicationRecord
  belongs_to :gallery_module, class_name: 'Admin::GalleryModule', counter_cache: true
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
    image.url(size)
  end

  def page
    gallery_module.page
  end

  def user_name
    user ? user.name : ''
  end

  def image_page
    gallery_module.show_on_page
  end

  def clear_page_cache
    gallery_module.clear_page_cache
  end
end
