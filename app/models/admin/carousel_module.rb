class Admin::CarouselModule < ApplicationRecord

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
