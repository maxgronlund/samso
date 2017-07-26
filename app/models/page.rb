# Dynamic page to hold content
class Page < ApplicationRecord
  belongs_to :user
  has_many :page_modules, dependent: :destroy
  has_many :admin_carousel_slide
  has_many :text_modules

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

  scope :active, -> { where(active: true) }

  def self.locales
    LOCALES.map { |locale| [I18n.t(locale), locale] }
  end

  def self.content_types
    [
      [I18n.t('page_module.text_module'), 'TextModule'],
      [I18n.t('page_module.carousel_module'), 'Admin::CarouselModule'],
      [I18n.t('page_module.subscription_module'), 'Admin::SubscriptionModule'],
      [I18n.t('page_module.blog_module'), 'Admin::BlogModule'],
      [I18n.t('page_module.post_module'), 'Admin::PostModule'],
      [I18n.t('page_module.dmi_module'), 'Admin::DmiModule'],
      [I18n.t('page_module.gallery_module'), 'Admin::GalleryModule']
    ]
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
