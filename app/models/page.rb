# Dynamic page to hold content
class Page < ApplicationRecord
  belongs_to :user
  has_many :page_modules, dependent: :destroy
  has_many :admin_carousel_slide

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

  PAGE_MODULES = [
    %w(text_module TextModule),
    %w(carousel_module Admin::CarouselModule)
  ].freeze

  scope :active, -> { where(active: true) }

  def self.locales
    LOCALES.map { |locale| [I18n.t(locale), locale] }
  end

  def self.content_types
    PAGE_MODULES.map { |page_module| [I18n.t(page_module[0]), page_module[1]] }
  end

  def author_name
    user.nil? ? '' : user.name
  end

  def self.menu_collection
    [
      [I18n.t('not_in_any_menus'), 'not_in_any_menus'],
      [I18n.t('menu_bar'), 'menu_bar']
    ]
  end

  def self.for_menu(menu_id)
    active.where(locale: I18n.locale.to_s, menu_id: menu_id)
  end

  def self.front_page
    page_id = Admin::SystemSetup.landing_page_id
    Page.where(id: page_id)
  end
end
