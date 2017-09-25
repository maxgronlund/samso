# show one image from the GGallery
class Admin::ImageModule < ApplicationRecord
  has_many :page_col_modules, as: :moduleable
  include PageColConcerns

  def title(gallery_image_id)
    galery_image(gallery_image_id).title
  end

  def body(gallery_image_id)
    galery_image(gallery_image_id).body
  end

  def image_url(gallery_image_id)
    galery_image(gallery_image_id).image.url(:full_size)
  end

  private

  def galery_image(gallery_image_id)
    @gallery_image ||= Admin::GalleryImage.find_by(id: gallery_image_id)
    return @gallery_image unless @gallery_image.nil?
    Admin::GalleryImage.last
  end
end
