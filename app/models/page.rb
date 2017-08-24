# Dynamic page to hold content
# rubocop:disable Style/ClassLength
class Page < ApplicationRecord
  belongs_to :user
  has_many :page_modules, dependent: :destroy
  has_many :admin_carousel_slide
  has_many :text_modules
  has_many :gallery_modules

  has_attached_file :row_1_background
  has_attached_file :row_2_background
  has_attached_file :row_3_background
  validates_attachment_content_type :row_1_background, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_content_type :row_2_background, content_type: %r{\Aimage\/.*\Z}
  validates_attachment_content_type :row_3_background, content_type: %r{\Aimage\/.*\Z}

  before_validation { row_1_background.clear if delete_row_1_background == '1' }
  before_validation { row_2_background.clear if delete_row_2_background == '1' }
  before_validation { row_3_background.clear if delete_row_3_background == '1' }
  attr_accessor :delete_row_1_background, :delete_row_2_background, :delete_row_3_background

  LOCALES = %w[da en].freeze

  LAYOUTS = %w[
    alabama
    alaska
    arizona
    arkansas
    california
    colorado
    connecticut
    delaware
    florida
    georgia
  ].freeze

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
      [I18n.t('page_module.gallery_module'), 'Admin::GalleryModule'],
      [I18n.t('page_module.image_module'), 'Admin::ImageModule']
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

  def footer
    @footer = Admin::Footer.find_by(id: footer_id)
  end

  def deletable?
    return false if Admin::SystemSetup.where(locale: locale, landing_page_id: id).any?
    return false if Admin::SystemSetup.where(locale: locale, subscription_page_id: id).any?
    return false if Admin::SystemSetup.where(locale: locale, post_page_id: id).any?
    return false if Admin::SystemSetup.where(locale: locale, welcome_page_id: id).any?
    true
  end

  def image1_url
    source = 'https://s3.eu-central-1.amazonaws.com' + row_1_background.url.gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/row_1_background/missing.png'
      source = nil
    end
    source
  end

  def image2_url
    source = 'https://s3.eu-central-1.amazonaws.com' + row_2_background.url.gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/row_1_background/missing.png'
      source = nil
    end
    source
  end

  def image3_url
    source = 'https://s3.eu-central-1.amazonaws.com' + row_3_background.url.gsub('//s3.amazonaws.com', '')
    if source == 'https://s3.eu-central-1.amazonaws.com/row_1_background/missing.png'
      source = nil
    end
    source
  end

  def row1_style
    style = "background-image: url(#{image1_url});"
    style += 'margin-top: 54px;'
    style += "padding: #{height_row_1}px 0;"
    style + "background-color: #{color_row_1}"
  end

  def row2_style
    style = "background-image: url(#{image2_url});"
    style += "padding: #{height_row_2}px 0;"
    style + "background-color: #{color_row_2}"
  end

  def row3_style
    style = "background-image: url(#{image3_url});"
    style += "padding: #{height_row_3}px 0;"
    style + "background-color: #{color_row_3}"
  end
end
