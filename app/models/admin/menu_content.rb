# frozen_string_literal: true

# stack of links to plop in to a vertical_menu_module
class Admin::MenuContent < ApplicationRecord
  has_many :menu_links, dependent: :destroy
end
