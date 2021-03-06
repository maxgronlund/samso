# frozen_string_literal: true

# link to a page / url
class Admin::MenuLink < ApplicationRecord
  belongs_to :menu_content, class_name: 'Admin::MenuContent'

  def page
    Page.find(page_id).presence
  rescue => e
    Page.first
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

  def self.next_position
    return 0 if Admin::MenuLink.last.nil?

    Admin::MenuLink.last.position. + 10
  end
end
