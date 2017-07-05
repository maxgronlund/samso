# Dynamic page to hold content
class Page < ApplicationRecord
  belongs_to :user
  has_many :page_modules, dependent: :destroy

  NOT_IN_ANY_MENUS = 'not_in_any_menus'.freeze
  TOP_MENU_BAR     = 'in_top_menu_bar'.freeze

  MENUS = [NOT_IN_ANY_MENUS, TOP_MENU_BAR].freeze
  LOCALES = %w(da en).freeze

  LAYOUTS = %w(
    alabama
    alaska
    arizona
    arkansas
    california
    colorado
    connecticut
    delaware
    florida
  ).freeze

  PAGE_MODULES = [%w(text_module TextModule)].freeze

  def self.menus
    MENUS.map { |menu| I18n.t(menu) }
  end

  def self.locales
    LOCALES.map { |locale| [I18n.t(locale), locale] }
  end

  def self.content_types
    PAGE_MODULES.map { |page_module| [I18n.t(page_module[0]), page_module[1]] }
  end

  def author_name
    user.nil? ? '' : user.name
  end
end
