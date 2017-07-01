# raw text to place on a page
class TextModule < ApplicationRecord
  def admin_page
    page_module.page
  end

  def page_module
    PageModule.find_by(
      moduleable_type: 'TextModule',
      moduleable_id: id
    )
  end
end
