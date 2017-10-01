# link to a page / url
class Admin::VerticalMenuLink < ApplicationRecord
  belongs_to :vertical_menu_content, class_name: 'Admin::VerticalMenuContent'

  def page
    @page ||= Page.find_by(id: page_id)
  end

  def page_title
    page ? page.title : ''
  end
end
