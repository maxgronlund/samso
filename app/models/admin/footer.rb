# Footer for pages
class Admin::Footer < ApplicationRecord
  def about_page
    @about_page ||= Page.find_by(id: about_page_id)
  end

  def copyright_page
    @copyright_page ||= Page.find_by(id: copyright_page_id)
  end

  def term_of_usage_page
    @term_of_usage_page ||= Page.find_by(id: term_of_usage_page_id)
  end
end
