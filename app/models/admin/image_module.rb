class Admin::ImageModule < ApplicationRecord
  include SectionPlugin

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::ImageModule',
      moduleable_id: id
    )
  end
end
