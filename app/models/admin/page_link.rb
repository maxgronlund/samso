# frozen_string_literal: true

# link to a page
class Admin::PageLink < ApplicationRecord
  belongs_to :page_link_module, class_name: 'Admin::PageLinkModule'
  belongs_to :page, optional: true

  validates :page_link_module, :name, :color, :background_color, presence: true

  def style
    "background-color: #{background_color}; padding: 6px;"
  end

  def link_style
    "color: #{color}"
  end
end
