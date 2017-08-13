# Gallery module
class Admin::GalleryModule < ApplicationRecord
  include SectionPlugin
  has_many :images, class_name: 'Admin::GalleryImage', dependent: :destroy, foreign_key: 'gallery_module_id'
  belongs_to :page, optional: true

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::GalleryModule',
      moduleable_id: id
    )
  end

  def latest_images
    images.order('created_at DESC')
  end

  def show_on_page
    Page.find_by(id: page_id)
  end
end
