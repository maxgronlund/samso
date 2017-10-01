# stack of links to plop in to a vertical_menu_module
class Admin::VerticalMenuContent < ApplicationRecord
  has_many :vertical_menu_links, dependent: :destroy
end
