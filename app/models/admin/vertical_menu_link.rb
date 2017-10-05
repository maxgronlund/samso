# link to a page / url
class Admin::VerticalMenuLink < ApplicationRecord
  belongs_to :vertical_menu_content, class_name: 'Admin::VerticalMenuContent'

  def page
    @page ||= Page.find_by(id: page_id)
  end

  def page_title
    page ? page.title : ''
  end

  def clear_page_cache
    Admin::SystemSetup.clear_page_cache
  end

  def style
    "background-color: #{background_color}; padding: 6px;"
  end

  def link_style
    "color: #{color}"
  end
end
