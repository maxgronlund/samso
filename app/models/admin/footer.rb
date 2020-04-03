# Footer for pages
class Admin::Footer < ApplicationRecord
  def about_page
    @about_page ||= Page.find(about_page_id)
  rescue => e
    nil
  end

  def copyright_page
    @copyright_page ||= Page.find(copyright_page_id)
  rescue => e
    nil
  end

  def term_of_usage_page
    @term_of_usage_page ||= Page.find(term_of_usage_page_id)
  rescue => e
    nil
  end
end
