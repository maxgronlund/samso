# Gallery module
class Admin::GalleryModule < ApplicationRecord
  include SectionPlugin
  has_many :images, class_name: 'Admin::GalleryImage', dependent: :destroy, foreign_key: 'gallery_module_id'

  #scope :latest_images, ->  { order('created_at DESC') }
  # scope :latest_images, -> { order('created_at DESC') }

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::GalleryModule',
      moduleable_id: id
    )
  end

  def latest_images
    images.order('created_at DESC')
  end

end
