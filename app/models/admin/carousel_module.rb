class Admin::CarouselModule < ApplicationRecord
  has_many :slides, class_name: 'Admin::CarouselSlide', dependent: :destroy

  def admin_page
    page_module.page
  end

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::CarouselModule',
      moduleable_id: id
    )
  end
end
