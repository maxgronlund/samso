# module for showning a post from the blog on a page
class Admin::PostModule < ApplicationRecord
  include SectionPlugin

  def page_module
    PageModule.find_by(
      moduleable_type: 'Admin::PostModule',
      moduleable_id: id
    )
  end
end
